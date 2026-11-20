package com.whatthefawk.rendering
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.math.Vector2D;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import com.getoffmyroof.engine.GameComponents;
   
   public class SpriteRenderer extends ARenderer
   {
      
      protected var _sprite:Sprite;
      private var m_remaster:Sprite;
      
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
         if(["TennisBallProjectile","BaseBallProjectile","BoomerangProjectile"].indexOf(param1.type) >= 0)
         {
            this.m_remaster = new Sprite();
            this.m_remaster.mouseEnabled = false;
            this.m_remaster.mouseChildren = false;
            this.m_remaster.addChild(this._sprite);
            this.m_remaster.visible = false;
            GameComponents.instance.getComponent("GameScreen").addChild(this.m_remaster);
         }
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         if(this.m_remaster == null)return;
         this.m_remaster.visible = _container.visible;
         this.m_remaster.x = _container.x + 106.6666667;
         this.m_remaster.y = _container.y;
         this.m_remaster.rotation = _container.rotation;
         this.m_remaster.scaleX = _container.scaleX;
         this.m_remaster.scaleY = _container.scaleY;
         this.m_remaster.alpha = _container.alpha;
      }

      override public function dispose() : void
      {
         if(this.m_remaster != null && this.m_remaster.parent != null)this.m_remaster.parent.removeChild(this.m_remaster);
         this.m_remaster = null;
         this._sprite = null;
         super.dispose();
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

