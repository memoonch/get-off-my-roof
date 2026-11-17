package com.whatthefawk.entity
{
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.rendering.EntityRenderer;
   import com.whatthefawk.utils.Params;
   
   public class EntityParams extends Params
   {
      
      public var customClass:Class;
      
      public var hitAreaPosition:Vector2D;
      
      public var scale:Number;
      
      public var rendererData:Object;
      
      public var layer:int;
      
      public var radius:Number;
      
      public var messageDispatcher:IMessageDispatcher;
      
      public var tags:Array;
      
      public var forceId:String;
      
      public var lifeTime:int;
      
      public var isCollidable:Boolean;
      
      public var rendererClass:Class;
      
      public var useHitAreaForCollisions:Boolean;
      
      public var hitAreaRadius:int;
      
      public var type:String;
      
      public var rotation:Number;
      
      public function EntityParams(param1:Object = null)
      {
         super();
         this.lifeTime = -1;
         this.tags = [];
         this.type = "Entity";
         this.layer = 1;
         this.scale = 1;
         this.radius = 0;
         this.rotation = 0;
         this.isCollidable = false;
         this.hitAreaRadius = -1;
         this.hitAreaPosition = new Vector2D();
         this.useHitAreaForCollisions = false;
         this.customClass = Entity;
         this.rendererClass = EntityRenderer;
         this.rendererData = {};
         applyParams(param1);
      }
   }
}

