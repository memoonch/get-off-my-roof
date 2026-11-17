package com.whatthefawk.audio
{
   import com.greensock.TweenMax;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   
   public class AudioManager extends EventDispatcher
   {
      
      protected var _globalVolumeBeforeMute:Number;
      
      protected var _maxChannels:int;
      
      protected var _isPaused:Boolean;
      
      protected var _audio:Dictionary;
      
      protected var _transforms:Dictionary;
      
      protected var _isMuted:Boolean;
      
      protected var _playlist:Array;
      
      protected var _groups:Dictionary;
      
      protected var _numChannels:int;
      
      public function AudioManager()
      {
         super();
         this._audio = new Dictionary();
         this._groups = new Dictionary();
         this._transforms = new Dictionary();
         this._playlist = [];
         this._maxChannels = 30;
         this._isPaused = false;
         this._isMuted = false;
         this._transforms[AudioTypes.SOUND] = new SoundTransform();
         this._transforms[AudioTypes.MUSIC] = new SoundTransform();
         this._transforms[AudioTypes.AMBIANCE] = new SoundTransform();
         this._transforms[AudioTypes.INTERFACE] = new SoundTransform();
      }
      
      public function stop(param1:String = null) : void
      {
         var _loc2_:Audio = null;
         if(param1 != null && !this.hasAudio(param1))
         {
            return;
         }
         if(param1)
         {
            this._audio[param1].stop();
         }
         else
         {
            for each(_loc2_ in this._audio)
            {
               _loc2_.stop();
            }
         }
      }
      
      public function crossFade(param1:String, param2:String, param3:Number = 3, param4:int = 0, param5:Number = 1, param6:Number = 0, param7:String = null) : void
      {
         if(!this._audio[param1])
         {
            return;
         }
         if(!this._audio[param2])
         {
            return;
         }
         this.play(param1,param4,0,param6,param7);
         this.volumeTo(param5,param3,param1);
         this.fadeOut(param2,param3);
      }
      
      public function volumeTo(param1:Number, param2:Number = 0, param3:String = null) : void
      {
         var _loc4_:Audio = null;
         if(!param3)
         {
            TweenMax.to(SoundMixer,param2,{"volume":param1});
            return;
         }
         for each(_loc4_ in this._audio)
         {
            if(_loc4_.ID == param3)
            {
               _loc4_.volumeTo(param1,param2);
            }
         }
      }
      
      private function onAudioComplete(param1:Event) : void
      {
      }
      
      public function getSoundTransform(param1:String = null) : SoundTransform
      {
         if(!param1 || param1 == AudioTypes.GLOBAL)
         {
            return SoundMixer.soundTransform;
         }
         if(!this._transforms[param1])
         {
            throw new Error("<AudioManager::getTransform> Audio type " + param1 + " does not exist.");
         }
         return this._transforms[param1];
      }
      
      public function mute() : void
      {
         if(this._isMuted)
         {
            return;
         }
         this._isMuted = true;
         this._globalVolumeBeforeMute = SoundMixer.soundTransform.volume;
         this.volumeTo(0);
         dispatchEvent(new AudioEvent(AudioEvent.MUTE));
      }
      
      public function hasAudio(param1:String) : Boolean
      {
         return !this._audio[param1] ? false : true;
      }
      
      public function unpause() : void
      {
         var _loc1_:Audio = null;
         if(!this._isPaused)
         {
            return;
         }
         this._isPaused = false;
         for each(_loc1_ in this._audio)
         {
            _loc1_.unpause();
         }
         dispatchEvent(new AudioEvent(AudioEvent.UNPAUSE));
      }
      
      public function get isMuted() : Boolean
      {
         return this._isMuted;
      }
      
      public function register(param1:AudioParams) : void
      {
         var _loc3_:String = null;
         var _loc2_:Audio = new Audio(param1);
         _loc2_.addEventListener(Audio.COMPLETE,this.onAudioComplete,false,0,true);
         this._audio[param1.audioID] = _loc2_;
         for each(_loc3_ in param1.groupIDs)
         {
            if(!this._groups[_loc3_])
            {
               this._groups[_loc3_] = [];
            }
            this._groups[_loc3_].push(param1.audioID);
         }
      }
      
      public function isPlaying(param1:String) : Boolean
      {
         if(!this.hasAudio(param1))
         {
            return false;
         }
         var _loc2_:Audio = this._audio[param1];
         return _loc2_.isPlaying;
      }
      
      public function stopType(param1:String) : void
      {
         var _loc2_:Audio = null;
         for each(_loc2_ in this._audio)
         {
            if(_loc2_.type == param1)
            {
               _loc2_.stop();
            }
         }
      }
      
      public function playRandom(param1:String, param2:int = 0, param3:Number = 1, param4:Number = 0, param5:String = null) : void
      {
         if(!this._groups[param1])
         {
            return;
         }
         var _loc6_:Array = this._groups[param1];
         var _loc7_:int = Math.random() * _loc6_.length;
         var _loc8_:String = _loc6_[_loc7_];
         this.play(_loc8_,param2,param3,param4,param5);
      }
      
      public function stopChannel(param1:String) : void
      {
         var _loc2_:Audio = null;
         for each(_loc2_ in this._audio)
         {
            _loc2_.stop(param1);
         }
      }
      
      public function unmute() : void
      {
         if(!this._isMuted)
         {
            return;
         }
         this._isMuted = false;
         this.volumeTo(this._globalVolumeBeforeMute);
         dispatchEvent(new AudioEvent(AudioEvent.UNMUTE));
      }
      
      public function play(param1:String, param2:int = 0, param3:Number = 1, param4:Number = 0, param5:String = null) : void
      {
         if(!this.hasAudio(param1))
         {
            return;
         }
         var _loc6_:Audio = this._audio[param1];
         _loc6_.play(param2,param3,param4,param5);
      }
      
      public function pause() : void
      {
         var _loc1_:Audio = null;
         if(this._isPaused)
         {
            return;
         }
         this._isPaused = true;
         for each(_loc1_ in this._audio)
         {
            _loc1_.pause();
         }
         dispatchEvent(new AudioEvent(AudioEvent.PAUSE));
      }
      
      public function get isPaused() : Boolean
      {
         return this._isPaused;
      }
      
      public function fadeOut(param1:String, param2:Number = 3) : void
      {
         if(!this._audio[param1])
         {
            return;
         }
         var _loc3_:Audio = this._audio[param1];
         _loc3_.fadeOut(param2);
      }
      
      public function get globalVolumeBeforeMute() : Number
      {
         return this._globalVolumeBeforeMute;
      }
      
      public function modifySoundTransform(param1:String, param2:Number = NaN, param3:Number = NaN) : void
      {
         var _loc5_:Audio = null;
         if(!this._transforms[param1])
         {
            throw new Error("<AudioManager::getTransform> Audio type " + param1 + " does not exist.");
         }
         var _loc4_:SoundTransform = this._transforms[param1];
         _loc4_.volume = isNaN(param2) ? _loc4_.volume : param2;
         _loc4_.pan = isNaN(param3) ? _loc4_.pan : param3;
         for each(_loc5_ in this._audio)
         {
            if(_loc5_.type == param1)
            {
               _loc5_.modifySoundTransform(_loc4_.volume,_loc4_.pan);
            }
         }
      }
      
      public function panTo(param1:Number, param2:Number = 0, param3:String = null) : void
      {
      }
   }
}

