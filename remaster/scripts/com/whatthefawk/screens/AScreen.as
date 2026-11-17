package com.whatthefawk.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.events.Event;
   import flash.display.DisplayObject;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class AScreen extends MovieClip implements IScreenItem
   {
      
      private var m_parentScreen:IScreenItem;
      
      private var m_currentScreen:IScreenItem;
      
      private var m_childScreens:Dictionary;
      
      public function AScreen(param1:IScreenItem = null)
      {
         super();
         this.m_parentScreen = param1;
         this.m_currentScreen = this.m_parentScreen == null ? null : this.currentScreen;
         this.m_childScreens = new Dictionary();
         if(param1 != null)
         {
            addEventListener(Event.ADDED_TO_STAGE,this.layoutWidescreen,false,0,true);
         }
      }

      private function layoutWidescreen(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.layoutWidescreen);
         if(getQualifiedClassName(this) == "com.getoffmyroof.screens::GameScreen")
         {
            return;
         }
         if(this.m_parentScreen.parentScreen == null ||
            getQualifiedClassName(this.m_parentScreen) == "com.getoffmyroof.screens::GameScreen")
         {
            x += 106.6666667;
         }
         // Extend static background edges while keeping controls and artwork
         // at their original proportions and local coordinates.
         for(var i:int = 0; i < numChildren; i++)
         {
            var item:DisplayObject = getChildAt(i);
            if(item.width >= 630 && item.height >= 470 && item.height <= 500)
            {
               if(item.alpha < 0.99)
               {
                  // Keep transparent hit areas and dimmers live, including
                  // their original alpha and mouse behavior.
                  item.scaleX *= 1.333333333;
                  item.x -= 106.6666667;
                  break;
               }
               var art:BitmapData = new BitmapData(854,480,true,0);
               var base:Matrix = item.transform.matrix.clone();
               base.tx += 106.6666667;
               art.draw(item,base,item.transform.colorTransform,null,null,true);
               var mirror:Matrix = item.transform.matrix.clone();
               mirror.a = -mirror.a;
               mirror.c = -mirror.c;
               mirror.tx = 106.6666667-item.x;
               art.draw(item,mirror,item.transform.colorTransform,null,new Rectangle(0,0,106.6666667,480),true);
               mirror.tx = 1386.6666667-item.x;
               art.draw(item,mirror,item.transform.colorTransform,null,new Rectangle(746.6666667,0,107.3333333,480),true);
               var extended:Bitmap = new Bitmap(art,"auto",true);
               extended.x = -106.6666667;
               item.visible = false;
               addChildAt(extended,0);
               break;
            }
         }
      }
      
      public function removeChildScreen(param1:String) : void
      {
         if(this.m_childScreens[param1] != null)
         {
            this.m_childScreens[param1].dispose();
            removeChild(this.m_childScreens[param1]);
            delete this.m_childScreens[param1];
         }
      }
      
      public function addChildScreen(param1:String, param2:Class) : void
      {
         var _loc3_:IScreenItem = new param2(this);
         addChild(_loc3_ as Sprite);
         this.m_childScreens[param1] = _loc3_;
      }
      
      public function update(param1:int) : void
      {
         var _loc2_:IScreenItem = null;
         if(this.m_parentScreen == null && this.m_currentScreen != null)
         {
            this.m_currentScreen.update(param1);
         }
         for each(_loc2_ in this.m_childScreens)
         {
            _loc2_.update(param1);
         }
      }
      
      public function childScreens() : Array
      {
         var _loc2_:AScreen = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this.m_childScreens)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function get currentScreen() : IScreenItem
      {
         if(this.m_parentScreen)
         {
            return this.m_parentScreen.currentScreen;
         }
         return this.m_currentScreen;
      }
      
      public function clearChildScreens() : void
      {
         var _loc1_:IScreenItem = null;
         for each(_loc1_ in this.m_childScreens)
         {
            _loc1_.dispose();
         }
         this.m_childScreens = new Dictionary();
      }
      
      public function getChildScreen(param1:String) : IScreenItem
      {
         if(!this.m_childScreens[param1])
         {
            throw new Error("<AScreen> Child Screen " + param1 + " does not exist.");
         }
         return this.m_childScreens[param1];
      }
      
      public function setScreen(param1:Class) : void
      {
         if(this.m_parentScreen != null)
         {
            this.m_parentScreen.setScreen(param1);
            return;
         }
         if(this.m_currentScreen != null)
         {
            removeChild(this.m_currentScreen as Sprite);
            this.m_currentScreen.dispose();
         }
         this.m_currentScreen = new param1(this);
         addChild(this.m_currentScreen as Sprite);
      }
      
      public function get parentScreen() : IScreenItem
      {
         return this.m_parentScreen;
      }
      
      public function dispose() : void
      {
         this.m_parentScreen = null;
         this.m_currentScreen = null;
         this.m_childScreens = null;
      }
   }
}

