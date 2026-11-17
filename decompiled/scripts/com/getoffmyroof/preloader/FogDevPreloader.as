package com.getoffmyroof.preloader
{
   import SWFStats.Log;
   import com.getoffmyroof.engine.GameEngine;
   import flash.display.MovieClip;
   import flash.events.Event;
   import fog.as3.FogDevAPI;
   
   [SWF(width="640", height="480", backgroundColor="#ffffff", frameRate="30")]
   public class FogDevPreloader extends MovieClip
   {
      
      public var FogAPI:FogDevAPI;
      
      public function FogDevPreloader()
      {
         super();
         addFrameScript(1,this.frame2);
         Log.View(973,"4534514dc2ec",root.loaderInfo.loaderURL);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
      }
      
      public function afterPreloader(param1:Event) : void
      {
         var _loc2_:GameEngine = new GameEngine();
         _loc2_.initFogDevAPI(this.FogAPI);
         addChildAt(_loc2_,0);
         play();
      }
      
      public function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.FogAPI = new FogDevAPI({
            "id":"4d8c96dfdd99d",
            "root":this.root
         });
         this.FogAPI.Preloader.SetBackgroundColor(0,0);
         this.FogAPI.Preloader.Start(this.afterPreloader);
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}

