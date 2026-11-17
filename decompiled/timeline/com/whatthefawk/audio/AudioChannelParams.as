package com.whatthefawk.audio
{
   import com.whatthefawk.utils.Params;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   
   public class AudioChannelParams extends Params
   {
      
      public var soundChannel:SoundChannel;
      
      public var channelID:String;
      
      public var loops:int = 0;
      
      public var sound:Sound;
      
      public function AudioChannelParams(param1:Object)
      {
         super(param1);
      }
   }
}

