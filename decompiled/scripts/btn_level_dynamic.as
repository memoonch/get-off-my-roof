package
{
   import com.getoffmyroof.ui.GameLevelButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol604")]
   public dynamic class btn_level_dynamic extends GameLevelButton
   {
      
      public function btn_level_dynamic()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

