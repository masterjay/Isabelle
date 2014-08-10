package handler
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLVariables;
	
	import event.TiMoonCakeEvent;
	
	import lib.AppSetting;
	import lib.Customer;
	import lib.TiHttpRequestHelper;
	

	public class GetXmlDataHandler extends EventDispatcher
	{
		
		public function GetXmlDataHandler()
		{
			
			
		}
		
		public function fnRequestXmlData():void
		{
			var httpHelper:lib.TiHttpRequestHelper=new TiHttpRequestHelper();
			httpHelper.addEventListener(Event.COMPLETE, fnGetXmlDataComplete);
			var httpVars:URLVariables=new URLVariables();
			//httpVars.productID=productID;
			//httpVars.dealerID=dealerID;
			httpHelper.fnSendRequest(AppSetting.GET_CUSTOMER_DATA, httpVars);
		}
		
		private function fnGetXmlDataComplete(e:Event):void
		{
			var xml:XML = XML(e.currentTarget.data);
			
			for(var i:int=0;i<xml.customer.length();i++)
			{
				trace(xml.children().length());
				var c:Customer=new Customer();
				c.m_customerId=xml.customer[i].@customerId;
				c.m_name=xml.customer[i].name;
				c.m_phone=xml.customer[i].phone;
				c.m_email=xml.customer[i].email;
			//	c.m_address=xml.customer[i].address;
				c.m_message=xml.customer[i].message;
				
				AppSetting.m_customerHashMap.put(c.m_customerId,c);
				
				
				
			}
			
			var ev:TiMoonCakeEvent = new TiMoonCakeEvent(TiMoonCakeEvent.GET_XML_CUSTOMER_DATA)
				dispatchEvent(ev);
		}
	}
}