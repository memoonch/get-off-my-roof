package com.whatthefawk.rendering
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.entity.IGameObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   
   public class ARenderer extends EventDispatcher implements IGameObject
   {
      
      private var m_previousScale:Number;
      
      protected var _entity:Entity;
      
      protected var _container:Sprite;
      
      protected var _camera:GameCamera;
      
      protected var _viewBoxY:Number;
      
      private var m_isVisible:Boolean;
      
      protected var _viewBoxX:Number;
      
      protected var _viewBoxWidth:Number;
      
      protected var g:Graphics;
      
      private var m_delayUpdateOneTick:Boolean;
      
      protected var _viewBoxHeight:Number;
      
      protected var _canvas:DisplayObjectContainer;
      
      public function ARenderer(param1:Entity, param2:GameCamera, param3:DisplayObjectContainer, param4:Object = null)
      {
         super();
         this._entity = param1;
         this._camera = param2;
         this._canvas = param3;
         this._container = new Sprite();
         this.g = this._container.graphics;
         this._canvas.addChild(this._container);
         this._container.visible = false;
         this.m_delayUpdateOneTick = true;
      }
      
      public function update(param1:int) : void
      {
         if(this.m_delayUpdateOneTick)
         {
            this.m_delayUpdateOneTick = false;
            return;
         }
         this.updateViewBox();
         this.processVisibility();
         if(this.m_isVisible)
         {
            this.draw();
            if(this._entity.scale != this.m_previousScale)
            {
               this.m_previousScale = this._entity.scale;
               this._container.scaleX = this._entity.scale;
               this._container.scaleY = this._entity.scale;
            }
            this._container.x = this._entity.currentPos.x - this._camera.currentPos.x + this._camera.bounds.width * 0.5;
            this._container.y = this._entity.currentPos.y - this._camera.currentPos.y + this._camera.bounds.height * 0.5;
         }
      }
      
      protected function updateViewBox() : void
      {
         throw new Error("<ARenderer::updateViewBox()> Abstract function must be overriden!");
      }
      
      public function get entity() : Entity
      {
         return this._entity;
      }
      
      public function dispose() : void
      {
         this._canvas.removeChild(this._container);
         this._entity = null;
         this._camera = null;
         this._canvas = null;
         this._container = null;
         this.g = null;
      }
      
      private function processVisibility() : void
      {
         if(this._viewBoxX + this._viewBoxWidth < this._camera.bounds.left)
         {
            this.m_isVisible = false;
            this._container.visible = false;
         }
         else if(this._viewBoxX > this._camera.bounds.left + this._camera.bounds.width)
         {
            this.m_isVisible = false;
            this._container.visible = false;
         }
         else if(this._viewBoxY + this._viewBoxHeight < this._camera.bounds.top)
         {
            this.m_isVisible = false;
            this._container.visible = false;
         }
         else if(this._viewBoxY > this._camera.bounds.top + this._camera.bounds.height)
         {
            this.m_isVisible = false;
            this._container.visible = false;
         }
         else
         {
            this.m_isVisible = true;
            this._container.visible = true;
         }
      }
      
      protected function draw() : void
      {
         throw new Error("<ARenderer::draw()> Abstract function must be overriden!");
      }
   }
}

