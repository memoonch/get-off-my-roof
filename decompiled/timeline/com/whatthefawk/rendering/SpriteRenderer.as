package com.whatthefawk.rendering
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.math.Vector2D;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class SpriteRenderer extends ARenderer
   {
      
      protected var _sprite:Sprite;
      
      public function SpriteRenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object = null)
      {
         super(param1,param2,param3);
         if(param4.sprite == null || !(param4.sprite is Class))
         {
            throw new ArgumentError("<SpriteRenderer> a_data.sprite must contain a variable of type Class which subclasses the Sprite Class.");
         }
         this._sprite = new param4.sprite();
         this._sprite.x = -this._sprite.width * 0.5;
         this._sprite.y = -this._sprite.height * 0.5;
         _container.addChild(this._sprite);
      }
      
      override protected function updateViewBox() : void
      {
         _viewBoxX = _entity.currentPos.x - this._sprite.width * 0.5;
         _viewBoxY = _entity.currentPos.y - this._sprite.height * 0.5;
         _viewBoxWidth = this._sprite.width;
         _viewBoxHeight = this._sprite.height;
      }
      
      override protected function draw() : void
      {
         _container.rotation = _entity.rotation * Vector2D.RAD_TO_DEG;
      }
   }
}

