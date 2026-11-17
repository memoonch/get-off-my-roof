package com.getoffmyroof.ui
{
   import SWFStats.Log;
   import com.whatthefawk.audio.AudioEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class QuickMuteButton extends GameButton
   {
      
      protected var _muted:Boolean = false;
      
      public function QuickMuteButton()
      {
         super();
         if(_audioManager.isMuted)
         {
            this._muted = true;
            gotoAndStop("unmute");
         }
         _audioManager.addEventListener(AudioEvent.MUTE,this.onAudioManagerMute,false,0,true);
         _audioManager.addEventListener(AudioEvent.UNMUTE,this.onAudioManagerUnmute,false,0,true);
      }
      
      private function onAudioManagerMute(param1:Event) : void
      {
         this._muted = true;
         gotoAndStop("unmute");
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         if(!this._muted)
         {
            _audioManager.mute();
            Log.CustomMetric("Clicked Mute","Audio");
         }
         else
         {
            _audioManager.unmute();
            Log.CustomMetric("Clicked UnMute","Audio");
         }
      }
      
      private function onAudioManagerUnmute(param1:Event) : void
      {
         this._muted = false;
         gotoAndStop("mute");
      }
   }
}

