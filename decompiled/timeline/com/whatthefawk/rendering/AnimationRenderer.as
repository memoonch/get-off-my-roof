package com.whatthefawk.rendering
{
   import com.urbansquall.ginger.AnimationPlayer;
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import flash.display.DisplayObjectContainer;
   
   public class AnimationRenderer extends EntityRenderer
   {
      
      protected var _animationPlayer:AnimationPlayer;
      
      public var isAnimationPlayerVisible:Boolean = true;
      
      public function AnimationRenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object = null)
      {
         super(param1,param2,param3,param4);
         if(param4.animationPlayer == null || !(param4.animationPlayer is AnimationPlayer))
         {
            throw new Error("An Animation Player must be supplied to the Animation Renderer through a_data.animationPlayer.");
         }
         if(param4.isAnimationPlayerVisible != null)
         {
            this.isAnimationPlayerVisible = param4.isAnimationPlayerVisible;
         }
         this._animationPlayer = param4.animationPlayer.copy();
         this._animationPlayer.x = -this._animationPlayer.width * 0.5;
         this._animationPlayer.y = -this._animationPlayer.height * 0.5;
         _container.addChild(this._animationPlayer);
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         if(this.isAnimationPlayerVisible)
         {
            this._animationPlayer.update(param1);
         }
         this._animationPlayer.visible = this.isAnimationPlayerVisible;
      }
      
      override protected function updateViewBox() : void
      {
         _viewBoxX = _entity.currentPos.x - this._animationPlayer.width * 0.5;
         _viewBoxY = _entity.currentPos.y - this._animationPlayer.height * 0.5;
         _viewBoxWidth = this._animationPlayer.width;
         _viewBoxHeight = this._animationPlayer.height;
      }
      
      override public function dispose() : void
      {
         this._animationPlayer.dispose();
         this._animationPlayer = null;
         super.dispose();
      }
   }
}

