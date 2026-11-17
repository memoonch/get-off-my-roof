package com.getoffmyroof.ui
{
   import com.getoffmyroof.engine.GameComponents;
   import com.whatthefawk.audio.AudioManager;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class GameButton extends MovieClip
   {
      
      public static const UP_FRAME_LABEL:String = "up";
      
      public static const OVER_FRAME_LABEL:String = "over";
      
      public static const DOWN_FRAME_LABEL:String = "down";
      
      protected var _clickSoundID:String = "ButtonClick";
      
      protected var _mouseUpSoundID:String = null;
      
      protected var _mouseDownSoundID:String = null;
      
      protected var _audioManager:AudioManager;
      
      public var isEnabled:Boolean;
      
      protected var _rollOutSoundID:String = null;
      
      protected var _rollOverSoundID:String = "ButtonRollover";
      
      public function GameButton()
      {
         super();
         buttonMode = true;
         useHandCursor = true;
         mouseChildren = false;
         this._audioManager = GameComponents.instance.getAudioManager();
         this.isEnabled = true;
         addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOver,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,false,0,true);
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
         if(!this.isEnabled)
         {
            return;
         }
         if(this._mouseUpSoundID)
         {
            this._audioManager.play(this._mouseUpSoundID);
         }
         if(this.hasLabel(UP_FRAME_LABEL))
         {
            gotoAndStop(UP_FRAME_LABEL);
         }
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
         if(!this.isEnabled)
         {
            return;
         }
         if(this._rollOverSoundID)
         {
            this._audioManager.play(this._rollOverSoundID);
         }
         if(this.hasLabel(OVER_FRAME_LABEL))
         {
            gotoAndStop(OVER_FRAME_LABEL);
         }
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         if(!this.isEnabled)
         {
            return;
         }
         if(this._clickSoundID)
         {
            this._audioManager.play(this._clickSoundID);
         }
      }
      
      protected function onMouseDown(param1:MouseEvent) : void
      {
         if(!this.isEnabled)
         {
            return;
         }
         if(this._mouseDownSoundID)
         {
            this._audioManager.play(this._mouseDownSoundID);
         }
         if(this.hasLabel(DOWN_FRAME_LABEL))
         {
            gotoAndStop(DOWN_FRAME_LABEL);
         }
      }
      
      protected function onRollOut(param1:MouseEvent) : void
      {
         if(!this.isEnabled)
         {
            return;
         }
         if(this._rollOutSoundID)
         {
            this._audioManager.play(this._rollOutSoundID);
         }
         if(this.hasLabel(UP_FRAME_LABEL))
         {
            gotoAndStop(UP_FRAME_LABEL);
         }
      }
      
      protected function hasLabel(param1:String) : Boolean
      {
         var _loc3_:FrameLabel = null;
         var _loc2_:Array = [];
         for each(_loc3_ in currentScene.labels)
         {
            _loc2_.push(_loc3_.name);
         }
         if(_loc2_.indexOf(param1) != -1)
         {
            return true;
         }
         return false;
      }
      
      protected function dispose() : void
      {
         this._audioManager = null;
         removeEventListener(MouseEvent.CLICK,this.onClick);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
   }
}

