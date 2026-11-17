package
{
   import com.getoffmyroof.ui.GameLevelButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol585")]
   public dynamic class btn_survival_level_dynamic extends GameLevelButton
   {
      
      public function btn_survival_level_dynamic()
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

