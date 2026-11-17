package com.whatthefawk.ui
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class DragGhost extends Sprite
   {
      
      public var icon:MovieClip;
      
      protected var _icon:Sprite;
      
      protected var _data:Object;
      
      public function DragGhost(param1:Object = null)
      {
         super();
         this._data = param1;
         this._icon = this.icon;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function setIcon(param1:Sprite) : void
      {
         param1.alpha = 0.7;
         param1.x = param1.width / -2;
         param1.y = param1.height / -2;
         this._icon.addChild(param1);
      }
   }
}

