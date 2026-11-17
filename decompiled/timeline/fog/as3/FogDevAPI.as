package fog.as3
{
   import flash.display.MovieClip;
   import flash.events.ContextMenuEvent;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import fog.as3.utils.Debug;
   
   public class FogDevAPI extends MovieClip
   {
      
      public var Height:int;
      
      private var TestID:String = "4d4018e4964ac";
      
      public var Game:Object;
      
      public var Build:String = "0.15.0.0";
      
      public var Preloader:FogDevPreloader;
      
      public var Tracking:FogDevTracking;
      
      public var ID:String = "";
      
      public var Assets:FogDevAssets;
      
      public var Width:int;
      
      public var Sandbox:Boolean = false;
      
      public var Locked:Boolean = false;
      
      public var Clip:Object;
      
      public var Version:String = "2.1";
      
      public var Options:Object;
      
      public function FogDevAPI(param1:Object)
      {
         var ctxMenu:ContextMenu;
         var ctx1:ContextMenuItem;
         var ctx2:ContextMenuItem;
         var defaults:Object;
         var ctx3:ContextMenuItem;
         var ctx4:ContextMenuItem;
         var opt:Object = param1;
         this.Clip = new Object();
         this.Options = new Object();
         this.Game = new Object();
         super();
         defaults = {};
         this.Options = this.parseOptions(opt,defaults);
         this.Clip = this.Options.root;
         this.Game.URL = "";
         this.Game.Tag = "";
         this.Game.Title = "";
         this.Game.Related = new Array();
         this.ID = this.Options.id ? this.Options.id : "";
         this.Sandbox = this.Options.sandbox ? true : false;
         if(this.ID == "YOUR_ID_HERE")
         {
            this.ID = this.TestID;
         }
         if(!this.ID)
         {
            this.Locked = true;
         }
         this.Clip.stage.addChild(this);
         this.Width = this.Options.width ? int(this.Options.width) : int(this.Clip.stage.stageWidth);
         this.Height = this.Options.height ? int(this.Options.height) : int(this.Clip.stage.stageHeight);
         this.Preloader = new FogDevPreloader(this);
         this.Tracking = new FogDevTracking(this);
         this.Assets = new FogDevAssets(this);
         ctxMenu = new ContextMenu();
         ctxMenu.hideBuiltInItems();
         ctx1 = new ContextMenuItem("Play More Games");
         ctx1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,function(param1:ContextMenuEvent):void
         {
            Tracking.GotoURL();
         });
         ctx2 = new ContextMenuItem("Free Games For Your Website");
         ctx2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,function(param1:ContextMenuEvent):void
         {
            Tracking.GotoURL("http://www.freegamesforyourwebsite.com/");
         });
         ctx3 = new ContextMenuItem("Copyright © Free Online Games");
         ctx3.separatorBefore = true;
         ctx4 = new ContextMenuItem("FOG API Version " + this.Version);
         ctx4.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,function(param1:ContextMenuEvent):void
         {
            Tracking.GotoURL(Tracking.DevURL);
         });
         ctxMenu.customItems.push(ctx1,ctx2,ctx3,ctx4);
         this.Clip.contextMenu = ctxMenu;
         Debug.log(" ");
         Debug.log("- *","   ","Welcome to FogDevAPI v" + this.Version + " (Build " + this.Build + ")");
         Debug.log("- *","   ","If you need assistance or examples for this API, please visit:");
         Debug.log("- *","   ","; http://www.marcqualie.com/projects/fogdev/");
         Debug.log("- *");
         Debug.log("- *","   ","ID:",this.ID,this.Sandbox ? " (This Game is running in Sandbox Mode)" : "");
         Debug.log("- *","   ","Domain:",this.Tracking.Info.domain + " (" + (this.Tracking.isFogDomain() ? "Internal" : "External") + ")");
         Debug.log("- *","   ","Resolution:",this.Width," x ",this.Height);
         if(this.ID == this.TestID)
         {
            Debug.log(" ");
            Debug.log("- *","   ","=| This is a Demo ID. Please update your ID as soon as possible! |=");
         }
      }
      
      public function debug(param1:String) : void
      {
         return Debug.log(param1);
      }
      
      public function LibraryCall(param1:String, param2:Object) : *
      {
         var f:String = param1;
         var o:Object = param2;
         try
         {
            if(this.Tracking.Library[f])
            {
               return this.Tracking.Library[f](o);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function parseOptions(param1:Object, param2:Object) : Object
      {
         var _loc4_:String = null;
         var _loc3_:Object = {};
         for(_loc4_ in param2)
         {
            _loc3_[_loc4_] = param2[_loc4_];
         }
         if(param1)
         {
            for(_loc4_ in param1)
            {
               _loc3_[_loc4_] = param1[_loc4_];
            }
         }
         return _loc3_;
      }
      
      public function SiteLock() : void
      {
         this.Locked = true;
      }
   }
}

