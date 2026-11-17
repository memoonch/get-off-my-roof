package com.whatthefawk.rendering
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.math.Vector2D;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   
   public class MovieClipRenderer extends ARenderer
   {
      
      protected var _movieClip:MovieClip;
      
      public function MovieClipRenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object = null)
      {
         super(param1,param2,param3);
         if(param4.movieClip == null || !(param4.movieClip is Class))
         {
            throw new ArgumentError("<MovieClipRenderer> a_data.movieClip must contain a variable of type Class which subclasses the MovieClip Class.");
         }
         this._movieClip = new param4.movieClip();
         this._movieClip.x = -this._movieClip.width * 0.5;
         this._movieClip.y = -this._movieClip.height * 0.5;
         _container.addChild(this._movieClip);
      }
      
      override protected function draw() : void
      {
         _container.rotation = _entity.rotation * Vector2D.RAD_TO_DEG;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._movieClip = null;
      }
      
      override protected function updateViewBox() : void
      {
         _viewBoxX = _entity.currentPos.x - this._movieClip.width * 0.5;
         _viewBoxY = _entity.currentPos.y - this._movieClip.height * 0.5;
         _viewBoxWidth = this._movieClip.width;
         _viewBoxHeight = this._movieClip.height;
      }
   }
}

