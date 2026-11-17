package com.getoffmyroof.ui
{
   import com.getoffmyroof.assets.Assets;
   import com.getoffmyroof.inventory.Item;
   import com.getoffmyroof.shop.ShopEvent;
   import com.whatthefawk.ui.DragGhost;
   import com.whatthefawk.ui.DropEvent;
   import com.whatthefawk.utils.NumberUtil;
   import com.whatthefawk.utils.SpriteUtil;
   import com.whatthefawk.utils.StringUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class ItemBox extends MovieClip
   {
      
      public static const BUY_MODE:int = 1;
      
      public static const EQUIP_MODE:int = 2;
      
      public var txt_name:TextField;
      
      protected var _dragGhost:DragGhost;
      
      public var gfx_icon:MovieClip;
      
      public var txt_points:TextField;
      
      protected var _iconBox:Sprite;
      
      protected var _tfPoints:TextField;
      
      public var txt_info:TextField;
      
      protected var _tfInfo:TextField;
      
      public var btn_buy:btn_buy_class;
      
      protected var _btnBuy:Sprite;
      
      public var isEquipped:Boolean = false;
      
      protected var _item:Item;
      
      protected var _tfMeta:TextField;
      
      public var txt_meta:TextField;
      
      protected var _tfName:TextField;
      
      public function ItemBox()
      {
         super();
         this._iconBox = this.gfx_icon;
         this._dragGhost = new Assets.UI_DRAG_GHOST();
         this._tfName = this.txt_name;
         this._tfInfo = this.txt_info;
         this._tfMeta = this.txt_meta;
         this._tfPoints = this.txt_points;
         this._btnBuy = this.btn_buy;
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMousePress,false,0,true);
      }
      
      private function setIcon(param1:Sprite) : void
      {
         SpriteUtil.fitSpriteInSprite(this._iconBox,param1,10);
      }
      
      private function getMetaText(param1:Item) : String
      {
         var _loc2_:Array = [];
         if(param1.damage != "")
         {
            _loc2_.push("<b>Damage:</b> " + StringUtil.camelCase(param1.damage));
         }
         if(param1.explosionDamage != "")
         {
            _loc2_.push("<b>Explosion Damage:</b> " + StringUtil.camelCase(param1.explosionDamage));
         }
         if(param1.reach != "")
         {
            _loc2_.push("<b>Reach:</b> " + StringUtil.camelCase(param1.reach));
         }
         if(param1.direction != "")
         {
            _loc2_.push("<b>Direction:</b> " + StringUtil.camelCase(param1.direction));
         }
         return _loc2_.join("&nbsp;&nbsp;&nbsp;");
      }
      
      public function init(param1:Item, param2:int = 1) : void
      {
         this._item = param1;
         this.setMode(param2);
         this._tfName.htmlText = "<b>" + this._item.name + "</b>";
         this._tfInfo.htmlText = this._item.info;
         this._tfMeta.htmlText = this.getMetaText(this._item);
         this._tfPoints.htmlText = "<b>" + NumberUtil.addCommas(String(this._item.value)) + "</b>";
         if(Assets[this._item.icon])
         {
            this.setIcon(new Assets[this._item.icon]());
            this._dragGhost.setIcon(new Assets[this._item.icon]());
         }
      }
      
      public function setMode(param1:int) : void
      {
         gotoAndStop(param1);
         if(param1 == ItemBox.BUY_MODE)
         {
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onMousePress);
            this._btnBuy.addEventListener(MouseEvent.CLICK,this.onBuy,false,0,true);
         }
      }
      
      private function onBuy(param1:Event) : void
      {
         dispatchEvent(new ShopEvent(ShopEvent.BUY,{"item":this._item}));
      }
      
      private function onMousePress(param1:Event) : void
      {
         this._dragGhost.startDrag(true);
         stage.addChild(this._dragGhost);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseRelease,false,0,true);
      }
      
      private function onMouseRelease(param1:Event) : void
      {
         this._dragGhost.stopDrag();
         var _loc2_:String = this._dragGhost.dropTarget.parent.name;
         dispatchEvent(new DropEvent(DropEvent.DROP,{
            "item":this._item,
            "dropTarget":_loc2_
         }));
         stage.removeChild(this._dragGhost);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseRelease);
      }
   }
}

