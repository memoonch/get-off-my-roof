package com.whatthefawk.audio
{
   import com.whatthefawk.utils.Params;
   import flash.media.Sound;
   
   public class AudioParams extends Params
   {
      
      public var sound:Sound;
      
      public var minDelay:int = 200;
      
      public var audioID:String;
      
      public var groupIDs:Array = [];
      
      public var type:String = AudioTypes.SOUND;
      
      public var maxChannels:int = 30;
      
      public function AudioParams(param1:Object)
      {
         super(param1);
      }
   }
}

