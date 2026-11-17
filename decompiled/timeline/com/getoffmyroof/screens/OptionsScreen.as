package com.getoffmyroof.screens
{
   import com.bit101.components.HSlider;
   import com.bit101.components.Label;
   import com.getoffmyroof.engine.GameComponents;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.audio.AudioTypes;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.Root;
   import com.whatthefawk.screens.ScreenManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class OptionsScreen extends AScreen
   {
      
      protected var _screenManager:ScreenManager;
      
      public var btn_close:btn_close_class;
      
      protected var _audioManager:AudioManager;
      
      public function OptionsScreen(param1:IScreenItem = null)
      {
         super(param1);
         this._audioManager = GameComponents.instance.getAudioManager();
         this._screenManager = GameComponents.instance.getScreenManager();
         x = Root.WIDTH / 2 - width / 2;
         y = Root.HEIGHT / 2 - height / 2;
         this.initButtons();
         this.initVolumeControls();
      }
      
      private function initVolumeControls() : void
      {
         var _loc1_:int = 110;
         var _loc2_:int = 80;
         var _loc3_:int = 40;
         var _loc4_:HSlider = new HSlider(this,_loc1_,_loc2_,this.onGlobalVolumeSlider);
         _loc4_.value = this._audioManager.getSoundTransform().volume * 100;
         var _loc5_:HSlider = new HSlider(this,_loc1_,_loc2_ + _loc3_,this.onMusicVolumeSlider);
         _loc5_.value = this._audioManager.getSoundTransform(AudioTypes.MUSIC).volume * 100;
         var _loc6_:HSlider = new HSlider(this,_loc1_,_loc2_ + _loc3_ * 2,this.onSoundVolumeSlider);
         _loc6_.value = this._audioManager.getSoundTransform(AudioTypes.SOUND).volume * 100;
         var _loc7_:HSlider = new HSlider(this,_loc1_,_loc2_ + _loc3_ * 3,this.onInterfaceVolumeSlider);
         _loc7_.value = this._audioManager.getSoundTransform(AudioTypes.INTERFACE).volume * 100;
         addChild(_loc4_);
         addChild(_loc5_);
         addChild(_loc6_);
         addChild(_loc7_);
         this.addVolumeLabels(_loc4_,"Master Volume");
         this.addVolumeLabels(_loc5_,"Music Volume");
         this.addVolumeLabels(_loc6_,"Sound Volume");
         this.addVolumeLabels(_loc7_,"Interface Volume");
      }
      
      private function onMusicVolumeSlider(param1:Event) : void
      {
         var _loc2_:HSlider = param1.target as HSlider;
         this._audioManager.modifySoundTransform(AudioTypes.MUSIC,_loc2_.value / 100);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._audioManager = null;
         this._screenManager = null;
      }
      
      private function onSoundVolumeSlider(param1:Event) : void
      {
         var _loc2_:HSlider = param1.target as HSlider;
         this._audioManager.modifySoundTransform(AudioTypes.SOUND,_loc2_.value / 100);
      }
      
      private function onCloseClick(param1:Event) : void
      {
         dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function initButtons() : void
      {
         this.btn_close.addEventListener(MouseEvent.CLICK,this.onCloseClick,false,0,true);
      }
      
      private function addVolumeLabels(param1:HSlider, param2:String) : void
      {
         addChild(new Label(this,param1.x,param1.y - 20,param2));
         addChild(new Label(this,param1.x - 10,param1.y - 5,"0"));
         addChild(new Label(this,param1.x + param1.width,param1.y - 5,"100"));
      }
      
      private function onInterfaceVolumeSlider(param1:Event) : void
      {
         var _loc2_:HSlider = param1.target as HSlider;
         this._audioManager.modifySoundTransform(AudioTypes.INTERFACE,_loc2_.value / 100);
      }
      
      private function onGlobalVolumeSlider(param1:Event) : void
      {
         var _loc2_:HSlider = param1.target as HSlider;
         this._audioManager.volumeTo(_loc2_.value / 100,0);
      }
   }
}

