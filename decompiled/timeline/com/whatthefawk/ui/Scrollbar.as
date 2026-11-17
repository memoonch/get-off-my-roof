package com.whatthefawk.ui
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class Scrollbar extends MovieClip
   {
      
      protected var _content:Sprite;
      
      protected var _ctrl:Number;
      
      protected var _background:Sprite;
      
      protected var _bottom:Number;
      
      protected var _dragRect:Rectangle;
      
      protected var _area:Sprite;
      
      public var background:MovieClip;
      
      public var ruler:MovieClip;
      
      protected var _ruler:Sprite;
      
      protected var _scrollSpeed:int;
      
      protected var _range:Number;
      
      public function Scrollbar()
      {
         super();
         this._ruler = this.ruler;
         this._background = this.background;
         this._background.addEventListener(MouseEvent.MOUSE_DOWN,this.onBackgroundMouseDown,false,0,true);
         this._background.addEventListener(MouseEvent.MOUSE_DOWN,this.onDragStart,false,0,true);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage,false,0,true);
      }
      
      private function onBackgroundMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Number = param1.stageY - this.y - this._ruler.height / 2;
         if(_loc2_ > this._bottom)
         {
            _loc2_ = this._bottom;
         }
         this._ruler.y = _loc2_;
         this.updateContent();
      }
      
      public function init(param1:Sprite, param2:Sprite, param3:Sprite, param4:int = 15) : void
      {
         this._content = param1;
         this._content.mask = param2;
         if(param1.height < param2.height)
         {
            if(!isNaN(this._ctrl))
            {
               this._content.y = this._ctrl;
            }
            this.visible = false;
            return;
         }
         this._area = param3;
         this._ctrl = isNaN(this._ctrl) ? param1.y : this._ctrl;
         this._background.height = param3.height;
         this._bottom = this._background.height - this._ruler.height;
         this._range = this._bottom;
         this._dragRect = new Rectangle(0,0,0,this._bottom);
         this._scrollSpeed = int(this._bottom / param4);
         this._ruler.addEventListener(MouseEvent.MOUSE_DOWN,this.onDragStart,false,0,true);
      }
      
      private function onDragStop(param1:Event) : void
      {
         this._ruler.stopDrag();
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragScroll);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onDragStop);
      }
      
      private function onDragScroll(param1:Event) : void
      {
         this.updateContent();
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,false,0,true);
      }
      
      private function onMouseWheel(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(!this.visible)
         {
            return;
         }
         if(this._area.getRect(stage).contains(stage.mouseX,stage.mouseY))
         {
            _loc2_ = param1.delta;
            _loc3_ = this._ruler.y;
            _loc3_ += _loc2_ < 0 ? this._scrollSpeed : -this._scrollSpeed;
            if(_loc3_ > this._bottom)
            {
               _loc3_ = this._bottom;
            }
            else if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            this._ruler.y = _loc3_;
            this.updateContent();
         }
      }
      
      private function onDragStart(param1:Event) : void
      {
         this._ruler.startDrag(false,this._dragRect);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onDragScroll,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onDragStop,false,0,true);
      }
      
      private function updateContent() : void
      {
         var _loc1_:Number = (this._content.height - this._range) / this._range;
         var _loc2_:Number = this._ruler.y * _loc1_ - this._ctrl;
         this._content.y = -_loc2_;
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel);
         this._background.removeEventListener(MouseEvent.MOUSE_DOWN,this.onBackgroundMouseDown);
         this._background.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDragStart);
         this._ruler.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDragStart);
      }
   }
}

