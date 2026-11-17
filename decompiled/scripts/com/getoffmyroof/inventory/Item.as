package com.getoffmyroof.inventory
{
   public class Item
   {
      
      private var m_info:String;
      
      private var m_damage:String;
      
      private var m_type:String;
      
      private var m_icon:String;
      
      private var m_explosionDamage:String;
      
      private var m_name:String;
      
      private var m_value:int;
      
      private var m_reach:String;
      
      private var m_id:String;
      
      private var m_direction:String;
      
      public function Item(param1:ItemParams)
      {
         super();
         this.m_id = param1.id;
         this.m_name = param1.name;
         this.m_type = param1.type;
         this.m_info = param1.info;
         this.m_icon = param1.icon;
         this.m_value = param1.value;
         this.m_reach = param1.reach;
         this.m_damage = param1.damage;
         this.m_explosionDamage = param1.explosionDamage;
         this.m_direction = param1.direction;
      }
      
      public function get name() : String
      {
         return this.m_name;
      }
      
      public function get id() : String
      {
         return this.m_id;
      }
      
      public function get type() : String
      {
         return this.m_type;
      }
      
      public function get explosionDamage() : String
      {
         return this.m_explosionDamage;
      }
      
      public function get info() : String
      {
         return this.m_info;
      }
      
      public function get damage() : String
      {
         return this.m_damage;
      }
      
      public function get value() : int
      {
         return this.m_value;
      }
      
      public function get reach() : String
      {
         return this.m_reach;
      }
      
      public function get icon() : String
      {
         return this.m_icon;
      }
      
      public function get direction() : String
      {
         return this.m_direction;
      }
   }
}

