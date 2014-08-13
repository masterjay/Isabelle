package event
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import lib.Customer;
	
	
	
	public class TiMoonCakeEvent extends TiBasicEvent
	{
		public static const MOONCAKE_CLICK:String="MOONCAKE_CLICK"
		public static const GET_XML_CUSTOMER_DATA:String="GET_XML_CUSTOMER_DATA"
		public static const GET_XML_CUSTOMER_COUNT_DATA:String="GET_XML_CUSTOMER_COUNT_DATA"
		public static const ADD_CUSTOMER_DATA:String="ADD_CUSTOMER_DATA"
		public static const CLOSE_NEW_MESSAGE:String="CLOSE_NEW_MESSAGE"
		public static const CLOSE_POPUP_MSESSAGE:String="CLOSE_POPUP_MSESSAGE"
		public static const POPUP_MSESSAGE:String="POPUP_MSESSAGE"
		public static const SWAP_DEPTH:String="SWAP_DEPTH"
		public static const READY:String="READY"
		public var m_customer:Customer = new Customer();
		public function TiMoonCakeEvent(type:String, detail:String = "", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type,detail,bubbles);
		}
	}
}