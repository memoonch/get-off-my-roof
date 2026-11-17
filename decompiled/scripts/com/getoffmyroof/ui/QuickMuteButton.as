package com.getoffmyroof.ui
{
   import SWFStats.Log;
   import com.whatthefawk.audio.AudioEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol719")]
   public class QuickMuteButton extends GameButton
   {
      
      protected var _muted:Boolean = false;
      
      public function QuickMuteButton()
      {
         addFrameScript(0,this.frame1);
         super();
         if(_audioManager.isMuted)
         {
            this._muted = true;
            gotoAndStop("unmute");
         }
         _audioManager.addEventListener(AudioEvent.MUTE,this.onAudioManagerMute,false,0,true);
         _audioManager.addEventListener(AudioEvent.UNMUTE,this.onAudioManagerUnmute,false,0,true);
      }
      
      internal function frame1() : *
      {
         stop();
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

