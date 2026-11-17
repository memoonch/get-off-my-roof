package com.getoffmyroof.entity
{
   import com.whatthefawk.entity.Wall;
   import com.whatthefawk.math.Vector2D;
   
   public class RoofGroup
   {
      
      private var m_landingPositions:Array;
      
      private var m_roofs:Array;
      
      public function RoofGroup()
      {
         super();
         this.m_roofs = [];
         this.m_landingPositions = [];
      }
      
      public function getRandomWall() : Wall
      {
         var _loc1_:Roof = this.getRandomRoof();
         return _loc1_.getRandomWall();
      }
      
      public function getRandomRoof() : Roof
      {
         var _loc1_:int = Math.random() * this.m_roofs.length;
         return this.m_roofs[_loc1_];
      }
      
      public function getRandomLandingPosition() : Vector2D
      {
         var _loc1_:int = Math.random() * this.m_landingPositions.length;
         return this.m_landingPositions[_loc1_];
      }
      
      public function generateLandingPositions(param1:int = 100) : void
      {
         var _loc3_:Wall = null;
         var _loc4_:Vector2D = null;
         var _loc2_:int = param1;
         while(--_loc2_ > 0)
         {
            _loc3_ = this.getRandomWall();
            _loc4_ = _loc3_.getRandomPointOffWall(25,50,25,25);
            this.m_landingPositions.push(_loc4_);
         }
      }
      
      public function addRoof(param1:Roof) : void
      {
         this.m_roofs.push(param1);
      }
      
      public function dispose() : void
      {
         this.m_roofs = null;
         this.m_landingPositions = null;
      }
   }
}

