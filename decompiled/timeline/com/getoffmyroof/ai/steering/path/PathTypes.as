package com.getoffmyroof.ai.steering.path
{
   import com.whatthefawk.ai.steering.path.Path;
   import com.whatthefawk.ai.steering.path.PathFactory;
   import com.whatthefawk.ai.steering.path.PathParams;
   import com.whatthefawk.math.Vector2D;
   
   public class PathTypes
   {
      
      public function PathTypes()
      {
         super();
      }
      
      public static function register(param1:PathFactory) : void
      {
         param1.registerPath(new PathParams({
            "id":"HorizontalHigh",
            "type":Path.CLOSED,
            "waypoints":[new Vector2D(100,200),new Vector2D(275,120),new Vector2D(450,200)]
         }));
         param1.registerPath(new PathParams({
            "id":"HorizontalMedium",
            "type":Path.CLOSED,
            "waypoints":[new Vector2D(100,300),new Vector2D(275,220),new Vector2D(450,300)]
         }));
         param1.registerPath(new PathParams({
            "id":"HorizontalLow",
            "type":Path.CLOSED,
            "waypoints":[new Vector2D(100,310),new Vector2D(275,340),new Vector2D(450,310),new Vector2D(275,280)]
         }));
      }
   }
}

