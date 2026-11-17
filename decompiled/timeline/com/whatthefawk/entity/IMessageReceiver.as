package com.whatthefawk.entity
{
   public interface IMessageReceiver
   {
      
      function handleMessage(param1:Telegram) : Boolean;
   }
}

