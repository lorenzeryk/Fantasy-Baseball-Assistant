//
//  StatRequesting.swift
//  Fantasy-Baseball-Assistant
//
//  Created by Eryk Lorenz on 4/22/23.
//

import Foundation
import CoreData

extension DataRequester {
    func getPlayerStats(_ player: Player, persistenceController: PersistenceController) async -> Stats? {
        guard let returnedStats = await fetchStats(player: player) else {
            print("No stats returned")
            return nil
        }
        
        for fetchedPlayer in returnedStats.players {
            if (fetchedPlayer.id == player.api_id) {
                return convertStats(stats: fetchedPlayer, isPitcher: player.isPitcher(), persistenceController: persistenceController)
            }
        }
        
        print("Player not found in returned stats")
        return nil
    }

    private func fetchStats(player: Player) async -> ReturnedStats? {
        print("Attempting to fetch stats for \(player.first_name) \(player.last_name)")
        
        
        let fetchPlayerStatsTask = Task { () -> ReturnedStats? in
            let full_url = "\(base_url)/seasons/2023/REG/teams/\(player.team.teamID)/splits.json?api_key=\(api_key)"
            guard let url = URL(string: full_url) else {
                print("Failed to convert URL")
                return nil
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let data: Data
            let response: URLResponse
            
            do {
                (data, response) = try await URLSession.shared.data(from: url)
            } catch {
                print("Error requesting stats for \(player.first_name) \(player.last_name)")
                return nil
            }
            
            let httpResponse = response as? HTTPURLResponse
            if (httpResponse?.statusCode != 200) {
                print("Recieved \(httpResponse?.statusCode ?? 0) from server")
                if let errorCode = httpResponse?.value(forHTTPHeaderField: "X-Mashery-Error-Code") as? String {
                    if (errorCode == "ERR_403_DEVELOPER_OVER_QPS") {
                        throw responseError.overQPS
                    }
                }
                return nil
            }
            
            do {
                return try JSONDecoder().decode(ReturnedStats.self, from: data)
            } catch {
                print("Failed to convert json")
                print(error)
                return nil
            }
        }
        
        for _ in 0..<num_retries {
            do {
                return try await fetchPlayerStatsTask.result.get()
            } catch responseError.overQPS {
                let sleepTime = Int.random(in: min_sleep_retry...max_sleep_retry)
                print("Retry fetching player stats in \(sleepTime)")
                sleep(UInt32(sleepTime))
            } catch {
                return nil
            }
        }
        return nil
    }
    
    private func convertStats(stats: PlayerStats, isPitcher: Bool, persistenceController: PersistenceController) -> Stats? {
        if (isPitcher) {
            guard let statEntity = persistenceController.getDescription(entityName: "PitcherStats") else {
                print("Failed to get description for PitcherStats")
                return nil
            }
            
            guard let statBaseEntity = persistenceController.getDescription(entityName: "PitcherStatsBase") else {
                print("Failed to get description for PitcherStatsBase")
                return nil
            }
            
            return convertPitchingStats(stats: stats, statEntity: statEntity, statBaseEntity: statBaseEntity, context: persistenceController.container.viewContext)
        } else {
            guard let statEntity = persistenceController.getDescription(entityName: "FielderStats") else {
                print("Failed to get description for FielderStats")
                return nil
            }
            
            guard let statBaseEntity = persistenceController.getDescription(entityName: "FielderStatsBase") else {
                print("Failed to get description for FielderStatsBase")
                return nil
            }
            
            return convertHittingStats(stats: stats, statEntity: statEntity, statBaseEntity: statBaseEntity, context: persistenceController.container.viewContext)
        }
    }
    
    private func convertHittingStats(stats: PlayerStats, statEntity: NSEntityDescription, statBaseEntity: NSEntityDescription, context: NSManagedObjectContext?) -> Stats? {
        var localStats = Stats()
        localStats.hittingStats = FielderStats(entity: statEntity, baseStatEntity: statBaseEntity, context: context)
        
        guard let hittingStats = stats.splits.hitting else {
            print("Hitting stats not found")
            return nil
        }
        
        guard let overallStats = hittingStats.overall?.first else {
            print("Overall stats not found")
            return nil
        }
        
        guard let seasonStats = overallStats.total?.first else {
            print("Season stats not found")
            return nil
        }
        
        if overallStats.total?.first != nil {
            let seasonHittingStats: FielderStatsBase = FielderStatsBase(batting_average: seasonStats.avg, ab: seasonStats.ab, hits: seasonStats.h, homeruns: seasonStats.hr, runs: seasonStats.runs, rbi: seasonStats.rbi, stolen_bases: seasonStats.sb, obp: seasonStats.obp, slg: seasonStats.slg, ops: seasonStats.ops, single: seasonStats.s, double: seasonStats.d, triple: seasonStats.t, walks: seasonStats.bb, intentional_walks: seasonStats.ibb, hit_by_pitch: seasonStats.hbp, caught_stealing: seasonStats.cs, strike_outs: seasonStats.ktotal, entity: statBaseEntity, context: context)
            
            localStats.hittingStats!.season = seasonHittingStats
        } else {
            print("Season stats not found")
        }
        
        if (overallStats.day_night != nil) {
            for stat in overallStats.day_night! {
                if (stat.value == "day") {
                    let dayHittingStats: FielderStatsBase = FielderStatsBase(batting_average: stat.avg, ab: stat.ab, hits: stat.h, homeruns: stat.hr, runs: stat.runs, rbi: stat.rbi, stolen_bases: stat.sb, obp: stat.obp, slg: stat.slg, ops: stat.ops, single: stat.s, double: stat.d, triple: stat.t, walks: stat.bb, intentional_walks: stat.ibb, hit_by_pitch: stat.hbp, caught_stealing: stat.cs, strike_outs: stat.ktotal, key: "Day", entity: statBaseEntity, context: context)
                    
                    localStats.hittingStats!.day_night.insert(dayHittingStats)
                } else if (stat.value == "night") {
                    let nightHittingStats: FielderStatsBase = FielderStatsBase(batting_average: stat.avg, ab: stat.ab, hits: stat.h, homeruns: stat.hr, runs: stat.runs, rbi: stat.rbi, stolen_bases: stat.sb, obp: stat.obp, slg: stat.slg, ops: stat.ops, single: stat.s, double: stat.d, triple: stat.t, walks: stat.bb, intentional_walks: stat.ibb, hit_by_pitch: stat.hbp, caught_stealing: stat.cs, strike_outs: stat.ktotal, key: "Night", entity: statBaseEntity, context: context)
                    
                    localStats.hittingStats!.day_night.insert(nightHittingStats)
                }
            }
        } else {
            print("Day/Night stats not found")
        }
            
        if (overallStats.home_away != nil) {
            for stat in overallStats.home_away! {
                if (stat.value == "home") {
                    let homeHittingStats: FielderStatsBase = FielderStatsBase(batting_average: stat.avg, ab: stat.ab, hits: stat.h, homeruns: stat.hr, runs: stat.runs, rbi: stat.rbi, stolen_bases: stat.sb, obp: stat.obp, slg: stat.slg, ops: stat.ops, single: stat.s, double: stat.d, triple: stat.t, walks: stat.bb, intentional_walks: stat.ibb, hit_by_pitch: stat.hbp, caught_stealing: stat.cs, strike_outs: stat.ktotal, key: "Home", entity: statBaseEntity, context: context)
                    
                    localStats.hittingStats!.home_away.insert(homeHittingStats)
                } else if (stat.value == "away") {
                    let awayHittingStats: FielderStatsBase = FielderStatsBase(batting_average: stat.avg, ab: stat.ab, hits: stat.h, homeruns: stat.hr, runs: stat.runs, rbi: stat.rbi, stolen_bases: stat.sb, obp: stat.obp, slg: stat.slg, ops: stat.ops, single: stat.s, double: stat.d, triple: stat.t, walks: stat.bb, intentional_walks: stat.ibb, hit_by_pitch: stat.hbp, caught_stealing: stat.cs, strike_outs: stat.ktotal, key: "Away", entity: statBaseEntity, context: context)
                    
                    localStats.hittingStats!.home_away.insert(awayHittingStats)
                }
            }
        } else {
            print("Home/Away stats not found")
        }
        
        if (overallStats.month != nil) {
            for stat in overallStats.month! {
                let hittingStats: FielderStatsBase = FielderStatsBase(batting_average: stat.avg, ab: stat.ab, hits: stat.h, homeruns: stat.hr, runs: stat.runs, rbi: stat.rbi, stolen_bases: stat.sb, obp: stat.obp, slg: stat.slg, ops: stat.ops, single: stat.s, double: stat.d, triple: stat.t, walks: stat.bb, intentional_walks: stat.ibb, hit_by_pitch: stat.hbp, caught_stealing: stat.cs, strike_outs: stat.ktotal, key: stat.value ?? "Month Error", entity: statBaseEntity, context: context)
                
                localStats.hittingStats!.month.insert(hittingStats)
            }
        } else {
            print("Month stats not found")
        }
        
        if (overallStats.opponent != nil) {
            for stat in overallStats.opponent! {
                let hittingStats: FielderStatsBase = FielderStatsBase(batting_average: stat.avg, ab: stat.ab, hits: stat.h, homeruns: stat.hr, runs: stat.runs, rbi: stat.rbi, stolen_bases: stat.sb, obp: stat.obp, slg: stat.slg, ops: stat.ops, single: stat.s, double: stat.d, triple: stat.t, walks: stat.bb, intentional_walks: stat.ibb, hit_by_pitch: stat.hbp, caught_stealing: stat.cs, strike_outs: stat.ktotal, key: stat.name ?? "Name Error", entity: statBaseEntity, context: context)
                
                localStats.hittingStats!.byOpponent.insert(hittingStats)
            }
        } else {
            print("Oppoent stats not found")
        }
        
        return localStats
    }
    
    private func convertPitchingStats(stats: PlayerStats, statEntity: NSEntityDescription, statBaseEntity: NSEntityDescription, context: NSManagedObjectContext?) -> Stats? {
        var localStats = Stats()
        localStats.pitchingStats = PitcherStats(entity: statEntity, baseStatEntity: statBaseEntity, context: context)
        
        guard let pitching = stats.splits.pitching else {
            print("No pitching stats found")
            return nil
        }
        
        guard let overallStats = pitching.overall?.first else {
            print("No overall stats found")
            return nil
        }
        
        guard let seasonStats = overallStats.total?.first else {
            print("No season stats found")
            return nil
        }
        
        let seasonPitchingStats: PitcherStatsBase = PitcherStatsBase(win: seasonStats.win ?? 0, loss: seasonStats.loss ?? 0, ip_2: seasonStats.ip_2 ?? 0.0, h: seasonStats.h, era: seasonStats.era ?? 0.0, ktotal: seasonStats.ktotal, bb: seasonStats.bb, hr: seasonStats.hr, oba: seasonStats.oba, obp: seasonStats.obp ?? 0.0, slg: seasonStats.slg ?? 0.0, ops: seasonStats.ops ?? 0.0, save: seasonStats.save ?? 0, svo: seasonStats.svo ?? 0, play: seasonStats.play ?? 0, entity: statBaseEntity, context: context)
        
        if (overallStats.day_night != nil) {
            for stat in overallStats.day_night! {
                if (stat.value == "day") {
                    let dayHittingStats: PitcherStatsBase = PitcherStatsBase(win: stat.win ?? 0, loss: stat.loss ?? 0, ip_2: stat.ip_2 ?? 0.0, h: stat.h, era: stat.era ?? 0.0, ktotal: stat.ktotal, bb: stat.bb, hr: stat.hr, oba: stat.oba, obp: stat.obp ?? 0.0, slg: stat.slg ?? 0.0, ops: stat.ops ?? 0.0, save: stat.save ?? 0, svo: stat.svo ?? 0, key: "Day", play: stat.play ?? 0, entity: statBaseEntity, context: context)
                    
                    localStats.pitchingStats!.day_night.insert(dayHittingStats)
                } else if (stat.value == "night") {
                    let nightHittingStats: PitcherStatsBase = PitcherStatsBase(win: stat.win ?? 0, loss: stat.loss ?? 0, ip_2: stat.ip_2 ?? 0.0, h: stat.h, era: stat.era ?? 0.0, ktotal: stat.ktotal, bb: stat.bb, hr: stat.hr, oba: stat.oba, obp: stat.obp ?? 0.0, slg: stat.slg ?? 0.0, ops: stat.ops ?? 0.0, save: stat.save ?? 0, svo: stat.svo ?? 0, key: "Night", play: stat.play ?? 0, entity: statBaseEntity, context: context)
                    
                    localStats.pitchingStats!.day_night.insert(nightHittingStats)
                }
            }
        } else {
            print("Day/Night stats not found")
        }
            
        if (overallStats.home_away != nil) {
            for stat in overallStats.home_away! {
                if (stat.value == "home") {
                    let homeHittingStats: PitcherStatsBase = PitcherStatsBase(win: stat.win ?? 0, loss: stat.loss ?? 0, ip_2: stat.ip_2 ?? 0.0, h: stat.h, era: stat.era ?? 0.0, ktotal: stat.ktotal, bb: stat.bb, hr: stat.hr, oba: stat.oba, obp: stat.obp ?? 0.0, slg: stat.slg ?? 0.0, ops: stat.ops ?? 0.0, save: stat.save ?? 0, svo: stat.svo ?? 0, key: "Home", play: stat.play ?? 0, entity: statBaseEntity, context: context)
                    
                    localStats.pitchingStats!.home_away.insert(homeHittingStats)
                } else if (stat.value == "away") {
                    let nightHittingStats: PitcherStatsBase = PitcherStatsBase(win: stat.win ?? 0, loss: stat.loss ?? 0, ip_2: stat.ip_2 ?? 0.0, h: stat.h, era: stat.era ?? 0.0, ktotal: stat.ktotal, bb: stat.bb, hr: stat.hr, oba: stat.oba, obp: stat.obp ?? 0.0, slg: stat.slg ?? 0.0, ops: stat.ops ?? 0.0, save: stat.save ?? 0, svo: stat.svo ?? 0, key: "Away", play: stat.play ?? 0, entity: statBaseEntity, context: context)
                    
                    localStats.pitchingStats!.home_away.insert(nightHittingStats)
                }
            }
        } else {
            print("Home/Away stats not found")
        }
        
        if (overallStats.month != nil) {
            for stat in overallStats.month! {
                let pitchingStats: PitcherStatsBase = PitcherStatsBase(win: stat.win ?? 0, loss: stat.loss ?? 0, ip_2: stat.ip_2 ?? 0.0, h: stat.h, era: stat.era ?? 0.0, ktotal: stat.ktotal, bb: stat.bb, hr: stat.hr, oba: stat.oba, obp: stat.obp ?? 0.0, slg: stat.slg ?? 0.0, ops: stat.ops ?? 0.0, save: stat.save ?? 0, svo: stat.svo ?? 0, key: stat.value ?? "Month Error", play: stat.play ?? 0, entity: statBaseEntity, context: context)
                
                localStats.pitchingStats!.month.insert(pitchingStats)
            }
        } else {
            print("Month stats not found")
        }
        
        if (overallStats.opponent != nil) {
            for stat in overallStats.opponent! {
                let pitchingStats: PitcherStatsBase = PitcherStatsBase(win: stat.win ?? 0, loss: stat.loss ?? 0, ip_2: stat.ip_2 ?? 0.0, h: stat.h, era: stat.era ?? 0.0, ktotal: stat.ktotal, bb: stat.bb, hr: stat.hr, oba: stat.oba, obp: stat.obp ?? 0.0, slg: stat.slg ?? 0.0, ops: stat.ops ?? 0.0, save: stat.save ?? 0, svo: stat.svo ?? 0, key: stat.name ?? "Name Error", play: stat.play ?? 0, entity: statBaseEntity, context: context)
                
                localStats.pitchingStats!.byOpponent.insert(pitchingStats)
            }
        } else {
            print("Opponent stats not found")
        }
        
        localStats.pitchingStats!.season = seasonPitchingStats
        
        return localStats
    }
}
