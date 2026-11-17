package com.getoffmyroof.screens
{
   import SWFStats.Log;
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.Root;
   import com.whatthefawk.screens.ScreenManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TutorialScreen extends AScreen
   {
      
      public var btn_skip:btn_skip_class;
      
      protected var _screenManager:ScreenManager;
      
      public var btn_back:btn_back_class;
      
      public var btn_close:btn_close_class;
      
      public var btn_next:btn_next_class;
      
      protected var _playerController:PlayerController;
      
      protected var _btn_back_pos:Vector2D;
      
      public function TutorialScreen(param1:IScreenItem = null)
      {
         super(param1);
         this._screenManager = GameComponents.instance.getScreenManager();
         this._playerController = GameComponents.instance.getComponent("PlayerController");
         this._btn_back_pos = new Vector2D();
         x = Root.WIDTH / 2 - width / 2;
         y = Root.HEIGHT / 2 - height / 2;
         this.initButtons();
         if(this._playerController.hasSeenTutorial)
         {
            Log.CustomMetric("Reviewed Tutorial","Tutorial");
         }
      }
      
      private function initButtons() : void
      {
         this.btn_close.visible = false;
         this._btn_back_pos.set(this.btn_back.x,this.btn_back.y);
         this.btn_back.addEventListener(MouseEvent.CLICK,this.onBackClick,false,0,true);
         this.btn_next.addEventListener(MouseEvent.CLICK,this.onNextClick,false,0,true);
         this.btn_close.addEventListener(MouseEvent.CLICK,this.onCloseClick,false,0,true);
         this.btn_skip.addEventListener(MouseEvent.CLICK,this.onSkipClick,false,0,true);
         this.updateButtons();
      }
      
      public function updateButtons() : void
      {
         if(currentFrame == 1)
         {
            this.btn_back.visible = false;
         }
         else
         {
            this.btn_back.visible = true;
         }
         if(currentFrame == 3)
         {
            this.btn_next.visible = false;
            this.btn_skip.visible = false;
            this.btn_close.visible = true;
         }
         else
         {
            this.btn_next.visible = true;
            this.btn_skip.visible = true;
            this.btn_close.visible = false;
         }
      }
      
      private function onCloseClick(param1:Event) : void
      {
         if(!this._playerController.hasSeenTutorial)
         {
            Log.CustomMetric("Completed Tutorial","Tutorial");
         }
         this._playerController.hasSeenTutorial = true;
         dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function onSkipClick(param1:Event) : void
      {
         if(!this._playerController.hasSeenTutorial)
         {
            Log.CustomMetric("Skipped Tutorial","Tutorial");
         }
         dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function onBackClick(param1:Event) : void
      {
         var _loc2_:int = currentFrame - 1;
         Math.max(1,_loc2_);
         gotoAndStop(_loc2_);
         this.updateButtons();
      }
      
      private function onNextClick(param1:Event) : void
      {
         var _loc2_:int = currentFrame + 1;
         Math.min(3,_loc2_);
         gotoAndStop(_loc2_);
         this.updateButtons();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._screenManager = null;
         this._playerController = null;
         this._btn_back_pos = null;
      }
   }
}

