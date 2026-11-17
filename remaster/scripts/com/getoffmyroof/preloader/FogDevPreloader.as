package com.getoffmyroof.preloader
{
   import com.getoffmyroof.engine.GameEngine;
   import com.getoffmyroof.engine.GameComponents;
   import flash.display.MovieClip;
   import flash.events.Event;
   import fog.as3.FogDevAPI;
   
   [SWF(width="960", height="540", backgroundColor="#ffffff", frameRate="30")]
   public class FogDevPreloader extends MovieClip
   {
      
      public var FogAPI:FogDevAPI;
      
      public function FogDevPreloader()
      {
         super();
         stop();
         addFrameScript(1,this.frame2);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
      }
      
      public function afterPreloader(param1:Event) : void
      {
         if(GameComponents.instance != null)
         {
            return;
         }
         var _loc2_:GameEngine = new GameEngine();
         _loc2_.scaleX = _loc2_.scaleY = 1.125;
         _loc2_.initFogDevAPI(this.FogAPI);
         addChildAt(_loc2_,0);
         stop();
      }
      
      public function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.ENTER_FRAME,this.startWhenLoaded,false,0,true);
      }

      private function startWhenLoaded(param1:Event) : void
      {
         if(framesLoaded < totalFrames || loaderInfo.bytesLoaded < loaderInfo.bytesTotal)
         {
            return;
         }
         removeEventListener(Event.ENTER_FRAME,this.startWhenLoaded);
         // Keep the legacy API available for existing results/score code.
         // Its sponsor preloader is never started or displayed.
         this.FogAPI = new FogDevAPI({
            "id":"4d8c96dfdd99d",
            "root":this.root
         });
         this.afterPreloader(null);
         // Frame 2's mute button needs the engine's audio manager first.
         gotoAndStop(totalFrames);
         // Root timeline contains the persistent mute button.
         for(var i:int = 0; i < numChildren; i++)
         {
            if(getChildAt(i) != _engineDisplay())
            {
               getChildAt(i).scaleX *= 1.125;
               getChildAt(i).scaleY *= 1.125;
               getChildAt(i).x *= 1.125;
               getChildAt(i).y *= 1.125;
            }
         }
      }

      private function _engineDisplay() : GameEngine
      {
         return GameComponents.instance.getGameEngine();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}


