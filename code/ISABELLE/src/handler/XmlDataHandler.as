package handler
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLVariables;
	
	import event.TiMoonCakeEvent;
	
	import lib.AppSetting;
	import lib.Customer;
	import lib.TiHttpRequestHelper;
	

	public class XmlDataHandler extends EventDispatcher
	{
		
		public function XmlDataHandler()
		{
			
			
		}
		
		public function fnRequestMessageListXmlData():void
		{
			var httpHelper:lib.TiHttpRequestHelper=new TiHttpRequestHelper();
			httpHelper.addEventListener(Event.COMPLETE, fnGetMessageListXmlDataComplete);
			var httpVars:URLVariables=new URLVariables();
			//httpVars.productID=productID;
			//httpVars.dealerID=dealerID;
			httpHelper.fnSendRequest(AppSetting.GET_MESSAGELIST, httpVars);
		}
		
		private function fnGetMessageListXmlDataComplete(e:Event):void
		{
			var xml:XML = XML(e.currentTarget.data);
			trace(xml.children().length());
			AppSetting.m_customerNewHashMap.clear();
			for(var i:int=0;i<xml.children().length();i++)
			{
				
				var c:Customer=new Customer();
				c.m_customerId=xml.item[i].@id;
				c.m_name=xml.item[i].@surname;
				c.m_message=xml.item[i].@message;
			
				if(AppSetting.m_customerHashMap.getValue(c.m_customerId) ==null)
				{
					AppSetting.m_customerNewHashMap.put(c.m_customerId,c);
					AppSetting.m_customerHashMap.put(c.m_customerId,c);
				}
				
			}
			trace("AppSetting.m_customerHashMap size" + AppSetting.m_customerHashMap.size())
			var ev:TiMoonCakeEvent = new TiMoonCakeEvent(TiMoonCakeEvent.GET_XML_CUSTOMER_DATA)
				dispatchEvent(ev);
		}
		
		public function fnRequestMessageXmlData():void
		{
			var httpHelper:lib.TiHttpRequestHelper=new TiHttpRequestHelper();
			httpHelper.addEventListener(Event.COMPLETE, fnGetMessageXmlDataComplete);
			var httpVars:URLVariables=new URLVariables();
			httpVars.id="AE1521F2-655B-4218-A25A-C73770EAC0D8";
			//httpVars.dealerID=dealerID;
			httpHelper.fnSendRequest(AppSetting.GET_MESSAGE, httpVars);
		}
		
		private function fnGetMessageXmlDataComplete(e:Event):void
		{
			var xml:XML = XML(e.currentTarget.data);
			trace(xml.children().length());
			for(var i:int=0;i<xml.children().length();i++)
			{
				
				var c:Customer=new Customer();
				c.m_customerId=xml.item[i].@id;
				c.m_name=xml.item[i].@surname;
				c.m_message=xml.item[i].@message;
				
				
			}
			
			var ev:TiMoonCakeEvent = new TiMoonCakeEvent(TiMoonCakeEvent.GET_XML_CUSTOMER_DATA)
			dispatchEvent(ev);
		}
		
		
		public function fnAddNewCustomerToServer(c:Customer):void
		{
			var httpHelper:lib.TiHttpRequestHelper=new TiHttpRequestHelper();
			httpHelper.addEventListener(Event.COMPLETE, fnAddNewBlessMessageComplete);
			var httpVars:URLVariables=new URLVariables();
			httpVars.surname = c.m_surname;
			httpVars.blessing= c.m_message
			httpVars.name = c.m_name
			httpVars.mobile = c.m_phone
			httpVars.email = c.m_email
			httpVars.address = c.m_address;
			httpVars.isrequirement = c.m_isrequirement
			httpVars.requirementqty = c.m_requirementqty
			httpVars.isneedcontact = c.m_isneedcontact;
			httpHelper.fnSendRequest(AppSetting.ADD_MESSAGE, httpVars);
		}
		
		private function fnAddNewBlessMessageComplete(e:Event):void
		{
			var xml:XML = XML(e.currentTarget.data);
			if(xml.result == true)
			{
			   trace(xml.id)
			   var a:String = xml.id
			   AppSetting.m_myMessageId = xml.id
			   fnRequestMessageListXmlData();
			}
			
		}
	}
}