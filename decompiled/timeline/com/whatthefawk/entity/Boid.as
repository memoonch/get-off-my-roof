package com.whatthefawk.entity
{
   import com.whatthefawk.ai.FSM.StateMachine;
   import com.whatthefawk.ai.steering.SteeringBehavior;
   import com.whatthefawk.ai.steering.path.PathManager;
   
   public class Boid extends MovingEntity
   {
      
      protected var _pathManager:PathManager;
      
      protected var _steering:SteeringBehavior;
      
      protected var _state:StateMachine;
      
      public function Boid(param1:BoidParams)
      {
         super(param1);
         this._state = new StateMachine(this,param1.stateMachineParams);
         this._steering = new SteeringBehavior(this);
         this._pathManager = new PathManager();
      }
      
      override public function update(param1:int) : void
      {
         lifeTime.update(param1);
         setInitialValues(param1);
         calculateForces();
         this._steering.calculateForces();
         velocity.x += this._steering.force.x;
         velocity.y += this._steering.force.y;
         calculateFinalVelocity();
         updatePosition();
         updateHeading();
         this._state.update();
         updateChildren(param1);
      }
      
      override public function handleMessage(param1:Telegram) : Boolean
      {
         return this._state.handleMessage(param1);
      }
      
      public function get pathManager() : PathManager
      {
         return this._pathManager;
      }
      
      public function get steering() : SteeringBehavior
      {
         return this._steering;
      }
      
      public function get state() : StateMachine
      {
         return this._state;
      }
      
      override public function dispose() : void
      {
         this._state.dispose();
         this._state = null;
         this._steering.dispose();
         this._steering = null;
         this._pathManager.dispose();
         this._pathManager = null;
         super.dispose();
      }
   }
}

