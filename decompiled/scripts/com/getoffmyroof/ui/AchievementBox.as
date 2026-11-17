package com.getoffmyroof.ui
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class AchievementBox extends Sprite
   {
      
      protected var _name:String;
      
      public var lock:MovieClip;
      
      protected var _text:TextField;
      
      public var text:TextField;
      
      protected var _description:String;
      
      public function AchievementBox()
      {
         super();
      }
      
      protected function onMouseOut(param1:Event) : void
      {
         this._text.htmlText = this._name;
      }
      
      protected function onMouseOver(param1:Event) : void
      {
         this._text.htmlText = this._description;
      }
      
      public function init(param1:*, param2:*) : void
      {
         this._name = param1;
         this._description = param2;
         this._text = this.text;
         this._text.htmlText = this._name;
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,false,0,true);
      }
   }
}

