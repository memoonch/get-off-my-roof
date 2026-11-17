package fog.as3
{
   import flash.display.MovieClip;
   
   public class FogDevAssets extends MovieClip
   {
      
      private var MiniLogoClass:Class = FogDevAssets_MiniLogoClass;
      
      private var Core:FogDevAPI;
      
      public function FogDevAssets(param1:FogDevAPI)
      {
         super();
         this.Core = param1;
      }
      
      public function MiniLogo() : MovieClip
      {
         return new this.MiniLogoClass() as MovieClip;
      }
   }
}

