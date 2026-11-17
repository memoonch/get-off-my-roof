package com.whatthefawk.life.stats
{
   import flash.events.EventDispatcher;
   
   public class Stat extends EventDispatcher
   {
      
      public static const TEMP_VALUE:String = "temp_value";
      
      public static const BASE_VALUE:String = "base_value";
      
      public static const BOTH_VALUES:String = "both_values";
      
      private var m_minBaseValue:int;
      
      private var m_maxValue:int;
      
      private var m_baseValue:int;
      
      private var m_minValue:int;
      
      private var m_value:int;
      
      protected var _name:String;
      
      private var m_maxBaseValue:int;
      
      protected var _id:String;
      
      public function Stat(param1:StatParams)
      {
         super();
         this._id = param1.id;
         this._name = param1.name;
         this.m_value = param1.value;
         this.m_maxValue = param1.maxValue;
         this.m_minValue = param1.minValue;
         this.m_baseValue = isNaN(param1.baseValue) ? this.m_value : param1.baseValue;
         this.m_maxBaseValue = isNaN(param1.maxBaseValue) ? this.m_maxValue : param1.maxBaseValue;
         this.m_minBaseValue = isNaN(param1.minBaseValue) ? this.m_minValue : param1.minBaseValue;
      }
      
      public function setMinValue(param1:int, param2:String = "temp_value", param3:Boolean = true) : void
      {
         if(param2 == Stat.TEMP_VALUE || param2 == Stat.BOTH_VALUES)
         {
            this.m_minValue = param1;
         }
         if(param2 == Stat.BASE_VALUE || param2 == Stat.BOTH_VALUES)
         {
            this.m_minBaseValue = param1;
         }
         if(param3)
         {
            this.validateValues();
         }
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function reset() : void
      {
         this.m_value = this.baseValue;
         this.m_maxValue = this.maxBaseValue;
         this.m_minValue = this.minBaseValue;
      }
      
      public function modifyMaxValue(param1:int, param2:String = "temp_value", param3:Boolean = true) : void
      {
         if(param2 == Stat.TEMP_VALUE || param2 == Stat.BOTH_VALUES)
         {
            this.m_maxValue += param1;
         }
         if(param2 == Stat.BASE_VALUE || param2 == Stat.BOTH_VALUES)
         {
            this.m_maxBaseValue += param1;
         }
         if(param3)
         {
            this.validateValues();
         }
      }
      
      public function modifyValue(param1:int, param2:String = "temp_value", param3:Boolean = true) : void
      {
         if(param2 == Stat.TEMP_VALUE || param2 == Stat.BOTH_VALUES)
         {
            this.m_value += param1;
         }
         if(param2 == Stat.BASE_VALUE || param2 == Stat.BOTH_VALUES)
         {
            this.m_baseValue += param1;
         }
         if(param3)
         {
            this.validateValues();
         }
      }
      
      protected function validateValues() : void
      {
         if(this.value > this.maxValue)
         {
            this.m_value = this.maxValue;
         }
         else if(this.value < this.minValue)
         {
            this.m_value = this.minValue;
         }
         if(this.baseValue > this.maxBaseValue)
         {
            this.m_baseValue = this.maxBaseValue;
         }
         else if(this.baseValue < this.minBaseValue)
         {
            this.m_baseValue = this.minBaseValue;
         }
      }
      
      public function modifyMinValue(param1:int, param2:String = "temp_value", param3:Boolean = true) : void
      {
         if(param2 == Stat.TEMP_VALUE || param2 == Stat.BOTH_VALUES)
         {
            this.m_minValue += param1;
         }
         if(param2 == Stat.BASE_VALUE || param2 == Stat.BOTH_VALUES)
         {
            this.m_minBaseValue += param1;
         }
         if(param3)
         {
            this.validateValues();
         }
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get baseValue() : int
      {
         return this.m_baseValue;
      }
      
      public function get maxBaseValue() : int
      {
         return this.m_maxBaseValue;
      }
      
      public function get maxValue() : int
      {
         return this.m_maxValue;
      }
      
      public function setValue(param1:int, param2:String = "temp_value", param3:Boolean = true) : void
      {
         if(param2 == Stat.TEMP_VALUE || param2 == Stat.BOTH_VALUES)
         {
            this.m_value = param1;
         }
         if(param2 == Stat.BASE_VALUE || param2 == Stat.BOTH_VALUES)
         {
            this.m_baseValue = param1;
         }
         if(param3)
         {
            this.validateValues();
         }
      }
      
      public function get value() : int
      {
         return this.m_value;
      }
      
      public function get minBaseValue() : int
      {
         return this.m_minBaseValue;
      }
      
      public function setMaxValue(param1:int, param2:String = "temp_value", param3:Boolean = true) : void
      {
         if(param2 == Stat.TEMP_VALUE || param2 == Stat.BOTH_VALUES)
         {
            this.m_maxValue = param1;
         }
         if(param2 == Stat.BASE_VALUE || param2 == Stat.BOTH_VALUES)
         {
            this.m_maxBaseValue = param1;
         }
         if(param3)
         {
            this.validateValues();
         }
      }
      
      public function get minValue() : int
      {
         return this.m_minValue;
      }
   }
}

