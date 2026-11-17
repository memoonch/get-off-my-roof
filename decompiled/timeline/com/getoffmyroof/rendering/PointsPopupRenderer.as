package com.getoffmyroof.rendering
{
   import com.getoffmyroof.popups.PointsPopup;
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.rendering.MovieClipRenderer;
   import flash.display.DisplayObjectContainer;
   
   public class PointsPopupRenderer extends MovieClipRenderer
   {
      
      private var m_pointsPopup:PointsPopup;
      
      public function PointsPopupRenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object = null)
      {
         super(param1,param2,param3,param4);
         this.m_pointsPopup = param1 as PointsPopup;
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         _movieClip.txt_points.htmlText = "<b>" + this.m_pointsPopup.points + "</b>";
         if(_container.visible)
         {
            if(_container.alpha <= 0)
            {
               _container.alpha = 0;
               _container.visible = false;
            }
            else
            {
               _container.alpha -= 0.03;
            }
         }
      }
      
      override protected function draw() : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.m_pointsPopup = null;
      }
   }
}

