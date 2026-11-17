package com.getoffmyroof.save
{
   import flash.net.registerClassAlias;
   import flash.utils.Dictionary;
   
   public class ClassAliasRegistrar
   {
      
      public function ClassAliasRegistrar()
      {
         super();
      }
      
      public static function register() : void
      {
         registerClassAlias("PlayerVOClass",PlayerVO);
         registerClassAlias("IValueObjectClass",IValueObject);
         registerClassAlias("DictionaryClass",Dictionary);
      }
   }
}

