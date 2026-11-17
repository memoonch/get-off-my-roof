package com.whatthefawk.math
{
   public class Transformations
   {
      
      private static var m_mat:Matrix2D = new Matrix2D();
      
      public function Transformations()
      {
         super();
      }
      
      public static function vectorToWorldSpace(param1:Vector2D, param2:Vector2D, param3:Vector2D) : Vector2D
      {
         var _loc4_:Vector2D = param1.copy();
         m_mat.Set();
         m_mat.rotateVector(param2,param3);
         m_mat.transformVector(_loc4_);
         return _loc4_;
      }
      
      public static function pointToLocalSpace(param1:Vector2D, param2:Vector2D, param3:Vector2D, param4:Vector2D) : Vector2D
      {
         var _loc5_:Vector2D = param1.copy();
         var _loc6_:Number = -param4.dot(param2);
         var _loc7_:Number = -param4.dot(param3);
         m_mat.Set(param2.x,param3.x,0,param2.y,param3.y,0,_loc6_,_loc7_);
         m_mat.transformVector(_loc5_);
         return _loc5_;
      }
      
      public static function vectorToLocalSpace(param1:Vector2D, param2:Vector2D, param3:Vector2D) : Vector2D
      {
         var _loc4_:Vector2D = param1.copy();
         m_mat.Set(param2.x,param3.x,0,param2.y,param3.y);
         m_mat.transformVector(_loc4_);
         return _loc4_;
      }
      
      public static function createWhiskers(param1:int, param2:Number, param3:Number, param4:Vector2D, param5:Vector2D) : Array
      {
         var _loc8_:Vector2D = null;
         var _loc6_:Number = param3 / (param1 - 1);
         var _loc7_:Array = [];
         var _loc9_:Number = -param3 * 0.5;
         var _loc10_:int = param1;
         while(--_loc10_ >= 0)
         {
            _loc8_ = param4;
            Transformations.rotateAroundOrigin(_loc8_,_loc9_);
            _loc7_.push(param5.addedTo(_loc8_.multipliedBy(param2)));
            _loc9_ += _loc6_;
         }
         return _loc7_;
      }
      
      public static function worldTransformPoints(param1:Array, param2:Vector2D, param3:Vector2D, param4:Vector2D, param5:Vector2D) : Array
      {
         throw new Error("This function is incomplete!");
      }
      
      public static function rotateAroundOrigin(param1:Vector2D, param2:Number) : void
      {
         var _loc3_:Matrix2D = new Matrix2D();
         _loc3_.rotate(param2);
         _loc3_.transformVector(param1);
      }
      
      public static function pointToWorldSpace(param1:Vector2D, param2:Vector2D, param3:Vector2D, param4:Vector2D) : Vector2D
      {
         var _loc5_:Vector2D = param1.copy();
         m_mat.Set();
         m_mat.rotateVector(param2,param3);
         m_mat.translate(param4.x,param4.y);
         m_mat.transformVector(_loc5_);
         return _loc5_;
      }
   }
}

