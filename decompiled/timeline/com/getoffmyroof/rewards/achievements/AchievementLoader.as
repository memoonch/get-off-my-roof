package com.getoffmyroof.rewards.achievements
{
   import com.whatthefawk.rewards.achievements.AchievementManager;
   
   public class AchievementLoader
   {
      
      protected var _achievementManager:AchievementManager;
      
      public function AchievementLoader(param1:AchievementManager)
      {
         super();
         this._achievementManager = param1;
      }
      
      public function load() : void
      {
         this._achievementManager.registerAchievement(new EliminatePigeonAchievement("pigeon_eliminator","Pigeon Eliminator",500));
         this._achievementManager.registerAchievement(new EliminatePigeonAchievement("poop_free_zone","Poop Free Zone",1000));
         this._achievementManager.registerAchievement(new EliminatePigeonAchievement("pigeons_worst_nightmare","Pigeons Worst Nightmare",2500));
         this._achievementManager.registerAchievement(new EliminatePigeonAchievement("endangering_the_species","Endangering the Species",5000));
         this._achievementManager.registerAchievement(new EliminatePigeonAchievement("letter_from_peta","Letter from P.E.T.A.",10000));
         this._achievementManager.registerAchievement(new ComboAchievement("apprentice_pigeon_hunter","Apprentice Pigeon Hunter",10));
         this._achievementManager.registerAchievement(new ComboAchievement("journeyman_pigeon_hunter","Journeyman Pigeon Hunter",20));
         this._achievementManager.registerAchievement(new ComboAchievement("expert_pigeon_hunter","Expert Pigeon Hunter",40));
         this._achievementManager.registerAchievement(new ComboAchievement("grandmaster_pigeon_hunter","Grandmaster Pigeon Hunter",80));
         this._achievementManager.registerAchievement(new CompleteLevelAchievement("milestone_1","Milestone 1","level005",5));
         this._achievementManager.registerAchievement(new CompleteLevelAchievement("milestone_2","Milestone 2","level010",10));
         this._achievementManager.registerAchievement(new CompleteLevelAchievement("milestone_3","Milestone 3","level015",15));
         this._achievementManager.registerAchievement(new CompleteLevelAchievement("milestone_4","Milestone 4","level020",20));
         this._achievementManager.registerAchievement(new CompleteLevelAchievement("milestone_5","Milestone 5","level025",25));
         var _loc1_:Array = ["Pigeon","FatPigeon","SoldierPigeon","CrazyPigeon","BomberPigeon","BlackPigeon","BlackFatPigeon","BlackSoldierPigeon","BlackCrazyPigeon","BlackBomberPigeon","BrownPigeon","BrownFatPigeon","BrownSoldierPigeon","BrownCrazyPigeon","BrownBomberPigeon"];
         this._achievementManager.registerAchievement(new EliminatePigeonTypesAchievement("feather_collector","Feather Collector",_loc1_,100));
         var _loc2_:Array = ["level001","level002","level003","level004","level005","level006","level007","level008","level009","level010","level011","level012","level013","level014","level015","level016","level017","level018","level019","level020","level021","level022","level023","level024","level025"];
         this._achievementManager.registerAchievement(new MedalOnLevelsAchievement("silver_medalist","Silver Medalist","Earn a silver medal or higher on each level!",3,_loc2_));
         this._achievementManager.registerAchievement(new MedalOnLevelsAchievement("gold_medalist","Gold Medalist","Earn a gold medal or higher on each level!",2,_loc2_));
         this._achievementManager.registerAchievement(new MedalOnLevelsAchievement("bling_bling","Bling Bling!","Earn a gold star medal on each level!",1,_loc2_));
         this._achievementManager.registerAchievement(new UnlockAllWeaponsAchievement("improvised_weapon_junkie","Improvised Weapon Junkie"));
         this._achievementManager.registerAchievement(new EarnPointsAchievement("millionaires_club","Millionaires Club",1000000));
      }
   }
}

