package com.whatthefawk.rewards.achievements
{
   import SWFStats.Log;
   import com.getoffmyroof.assets.Assets;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.ui.AchievementPopup;
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Bounce;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.screens.AScreen;
   import flash.utils.Dictionary;
   
   public class AchievementManager
   {
      
      protected var _achievements:Array;
      
      protected var _screen:AScreen;
      
      protected var _achievementMap:Dictionary;
      
      protected var _audioManager:AudioManager;
      
      public function AchievementManager(param1:AScreen)
      {
         super();
         this._audioManager = GameComponents.instance.getComponent("AudioManager");
         this._screen = param1;
         this._achievements = [];
         this._achievementMap = new Dictionary();
      }
      
      private function onPopupAchievementStart() : void
      {
         this._audioManager.play("AchievementDing");
      }
      
      public function get achievements() : Array
      {
         return this._achievements;
      }
      
      public function checkAchievement(param1:String, param2:Boolean = true) : Boolean
      {
         if(!this._achievementMap[param1])
         {
            throw new Error("<AchievementManager::checkAchievement> Achievement with ID " + param1 + " does not exist.");
         }
         var _loc3_:Boolean = IAchievement(this._achievementMap[param1]).check();
         if(_loc3_ && param2)
         {
            this.popupAchievements([this._achievementMap[param1]]);
         }
         return _loc3_;
      }
      
      public function forceCompleteAchievements(param1:Array) : void
      {
         var _loc2_:IAchievement = null;
         for each(_loc2_ in this._achievementMap)
         {
            if(param1.indexOf(_loc2_.id) != -1)
            {
               _loc2_.forceComplete();
            }
         }
      }
      
      private function onPopupAchievementRemove(param1:AchievementPopup) : void
      {
         param1.dispose();
      }
      
      public function registerAchievement(param1:IAchievement) : void
      {
         if(this._achievementMap[param1.id])
         {
            throw new Error("<AchievementManager::registerAchievement> Achievement " + param1.name + " has already been added.");
         }
         this._achievements.push(param1);
         this._achievementMap[param1.id] = param1;
      }
      
      private function popupAchievements(param1:Array) : void
      {
         var _loc5_:IAchievement = null;
         var _loc6_:AchievementPopup = null;
         var _loc7_:int = 0;
         var _loc8_:TimelineMax = null;
         if(param1.length == 0)
         {
            return;
         }
         var _loc2_:* = 0;
         var _loc3_:int = 3;
         var _loc4_:int = this._screen.height;
         for each(_loc5_ in param1)
         {
            _loc6_ = new Assets.UI_ACHIEVEMENT_POPUP();
            _loc6_.y = _loc4_;
            _loc6_.x = 20;
            _loc6_.alpha = 0;
            _loc6_.text.htmlText = "<b>" + _loc5_.name + "</b>";
            this._screen.addChild(_loc6_);
            _loc7_ = _loc2_++ * _loc3_;
            _loc8_ = new TimelineMax({
               "delay":_loc7_,
               "onStart":this.onPopupAchievementStart,
               "onComplete":this.onPopupAchievementRemove,
               "onCompleteParams":[_loc6_]
            });
            _loc8_.append(TweenMax.to(_loc6_,1,{
               "y":_loc4_ - 50,
               "ease":Bounce.easeOut,
               "alpha":1
            }));
            _loc8_.append(TweenMax.to(_loc6_,1,{
               "alpha":0,
               "delay":2
            }));
         }
      }
      
      public function get completedAchievementIDs() : Array
      {
         var _loc2_:IAchievement = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._achievementMap)
         {
            if(_loc2_.isComplete)
            {
               _loc1_.push(_loc2_.id);
            }
         }
         return _loc1_;
      }
      
      public function checkAchievements() : void
      {
         var _loc2_:IAchievement = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._achievementMap)
         {
            if(!_loc2_.isComplete)
            {
               if(_loc2_.check())
               {
                  Log.CustomMetric(_loc2_.name,"Achievements");
                  _loc1_.push(_loc2_);
               }
            }
         }
         this.popupAchievements(_loc1_);
      }
   }
}

