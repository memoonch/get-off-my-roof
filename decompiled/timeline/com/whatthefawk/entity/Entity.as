package com.whatthefawk.entity
{
   import com.whatthefawk.math.AABBox;
   import com.whatthefawk.math.Vector2D;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class Entity extends EventDispatcher implements IMessageReceiver
   {
      
      private static var m_nextID:int = 0;
      
      private var m_layer:int;
      
      private var m_scale:Number;
      
      public var hitAreaPosition:Vector2D;
      
      public var newPos:Vector2D;
      
      public var collisionChecked:Boolean;
      
      public var currentPos:Vector2D;
      
      protected var _type:String;
      
      public var radius:Number;
      
      public var isCollidable:Boolean;
      
      public var oldPos:Vector2D;
      
      private var m_id:String;
      
      public var bounds:AABBox;
      
      protected var _entityCount:int;
      
      private var m_messageDispatcher:IMessageDispatcher;
      
      protected var _lifeTime:LifeTime;
      
      protected var _parent:Entity;
      
      protected var _stepSize:Number;
      
      public var isDisposed:Boolean;
      
      public var useHitAreaForCollisions:Boolean;
      
      public var hitAreaRadius:int;
      
      protected var _tags:Array;
      
      protected var _entityMap:Dictionary;
      
      public var rotation:Number;
      
      public function Entity(param1:EntityParams)
      {
         super();
         this.m_layer = param1.layer;
         this.m_scale = param1.scale;
         this.m_messageDispatcher = param1.messageDispatcher;
         this._tags = param1.tags;
         this._type = param1.type;
         this._lifeTime = new LifeTime(param1.lifeTime);
         this._lifeTime.addEventListener(LifeTime.COMPLETE,this.onLifeTimeComplete,false,0,true);
         this._entityMap = new Dictionary();
         this._entityCount = 0;
         this.currentPos = new Vector2D();
         this.newPos = this.currentPos.copy();
         this.oldPos = this.currentPos.copy();
         this.radius = param1.radius;
         this.rotation = param1.rotation;
         this.bounds = new AABBox(this.currentPos,this.radius + this.radius,this.radius + this.radius);
         this.isCollidable = param1.isCollidable;
         this.collisionChecked = false;
         this.hitAreaRadius = param1.hitAreaRadius < 0 ? int(this.radius) : param1.hitAreaRadius;
         this.hitAreaPosition = param1.hitAreaPosition;
         this.useHitAreaForCollisions = param1.useHitAreaForCollisions;
         this.m_id = param1.forceId != null ? param1.forceId : "" + m_nextID++ + "-" + this._type;
      }
      
      public function get lifeTime() : LifeTime
      {
         return this._lifeTime;
      }
      
      public function get messageDispatcher() : IMessageDispatcher
      {
         return this.m_messageDispatcher;
      }
      
      public function removeChild(param1:String) : void
      {
         if(this._entityMap[param1] == null)
         {
            throw new Error("<Entity::removeChild()> No Entity found with matching ID: " + param1);
         }
         --this._entityCount;
         this._entityMap[param1].dispose();
         this._entityMap[param1] = null;
         delete this._entityMap[param1];
      }
      
      public function dispose() : void
      {
         var _loc1_:Object = null;
         this.isDisposed = true;
         this.m_messageDispatcher = null;
         this._tags = null;
         this._parent = null;
         this._lifeTime = null;
         this.currentPos = null;
         this.newPos = null;
         this.oldPos = null;
         this.bounds = null;
         this.hitAreaPosition = null;
         for(_loc1_ in this._entityMap)
         {
            Entity(this._entityMap[_loc1_]).dispose();
            delete this._entityMap[_loc1_];
         }
         this._entityMap = null;
         dispatchEvent(new EntityEvent(EntityEvent.DISPOSE));
      }
      
      public function get id() : String
      {
         return this.m_id;
      }
      
      public function set scale(param1:Number) : void
      {
         this.m_scale = param1;
         dispatchEvent(new EntityEvent(EntityEvent.CHANGE_SCALE,param1));
      }
      
      public function get tags() : Array
      {
         return this._tags;
      }
      
      public function get parent() : Entity
      {
         return this._parent;
      }
      
      public function getChildByID(param1:String) : Entity
      {
         return this._entityMap[param1];
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function isHitAreaOverlapping(param1:Entity) : Boolean
      {
         var _loc2_:Boolean = this.useHitAreaForCollisions;
         var _loc3_:Boolean = param1.useHitAreaForCollisions;
         var _loc4_:Vector2D = _loc2_ ? this.currentPos.addedTo(this.hitAreaPosition) : this.currentPos;
         var _loc5_:int = _loc2_ ? this.hitAreaRadius : int(this.radius);
         var _loc6_:Vector2D = _loc3_ ? param1.currentPos.addedTo(param1.hitAreaPosition) : param1.currentPos;
         var _loc7_:int = _loc3_ ? param1.hitAreaRadius : int(param1.radius);
         var _loc8_:Number = _loc4_.distanceSqTo(_loc6_);
         var _loc9_:Number = _loc5_ + _loc7_;
         return _loc8_ < _loc9_ * _loc9_ ? true : false;
      }
      
      public function isOverlapping(param1:Entity) : Boolean
      {
         var _loc2_:Number = this.currentPos.distanceSqTo(param1.currentPos);
         var _loc3_:Number = this.radius + param1.radius;
         return _loc2_ < _loc3_ * _loc3_ ? true : false;
      }
      
      public function handleMessage(param1:Telegram) : Boolean
      {
         return false;
      }
      
      protected function onLifeTimeComplete(param1:Event) : void
      {
      }
      
      public function isOverlappingBounds(param1:Entity) : Boolean
      {
         return this.bounds.isOverlapping(param1.bounds);
      }
      
      public function removeChildren(param1:Class = null) : void
      {
         var _loc2_:Entity = null;
         for each(_loc2_ in this._entityMap)
         {
            if(param1)
            {
               if(!(_loc2_ is param1))
               {
                  continue;
               }
            }
            this.removeChild(_loc2_.id);
         }
      }
      
      public function get scale() : Number
      {
         return this.m_scale;
      }
      
      protected function setInitialValues(param1:int) : void
      {
         this._stepSize = param1 * 0.001;
         this.oldPos.x = this.currentPos.x;
         this.oldPos.y = this.currentPos.y;
         this.currentPos.x = this.newPos.x;
         this.currentPos.y = this.newPos.y;
         this.bounds.moveTo(this.currentPos);
      }
      
      public function get screenPos() : Vector2D
      {
         return GameWorld(this.parent).getScreenPos(this.currentPos);
      }
      
      public function update(param1:int) : void
      {
         this.lifeTime.update(param1);
         this.setInitialValues(param1);
         this.updateChildren(param1);
      }
      
      public function get layer() : int
      {
         return this.m_layer;
      }
      
      public function set parent(param1:Entity) : void
      {
         if(this._parent == param1)
         {
            return;
         }
         if(this._parent)
         {
            this._parent.removeChild(this.id);
         }
         this._parent = param1;
         if(Boolean(this._parent) && this._parent.getChildByID(this.m_id) == null)
         {
            this._parent.addChild(this);
         }
      }
      
      public function isOverlappingCircle(param1:Vector2D, param2:Number) : Boolean
      {
         var _loc3_:Number = this.currentPos.distanceSqTo(param1);
         var _loc4_:Number = this.radius + param2;
         return _loc3_ < _loc4_ * _loc4_ ? true : false;
      }
      
      protected function updateChildren(param1:int) : void
      {
         var _loc2_:Entity = null;
         for each(_loc2_ in this._entityMap)
         {
            _loc2_.update(param1);
         }
      }
      
      override public function toString() : String
      {
         return "<" + this.id + ">";
      }
      
      public function get stepSize() : Number
      {
         return this._stepSize;
      }
      
      public function getChildren(param1:Class = null) : Array
      {
         var _loc4_:Entity = null;
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         for each(_loc4_ in this._entityMap)
         {
            if(param1)
            {
               if(!(_loc4_ is param1))
               {
                  continue;
               }
            }
            _loc3_[_loc2_] = _loc4_;
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function addChild(param1:Entity) : void
      {
         if(this._entityMap[param1.id] != null)
         {
            throw new Error("<Entity::addChild()> There is already an Entity with this id. Ensure ID\'s are unique.");
         }
         ++this._entityCount;
         this._entityMap[param1.id] = param1;
         param1.parent = this;
      }
   }
}

