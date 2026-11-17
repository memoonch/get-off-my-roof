package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol541")]
   public dynamic class CountdownAnimation extends MovieClip
   {
      
      public function CountdownAnimation()
      {
         super();
         addFrameScript(105,this.frame106);
      }
      
      internal function frame106() : *
      {
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

