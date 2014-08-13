package lib
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	
	public class AppSetting
	{
		
		//public static var DOMAIN:String = "http://www.isabelle.com.tw/Mooncake2014/conn/";
		public static var DOMAIN:String = "http://isabelle.drowl.com.tw/Mooncake2014/conn/";
	//	public static var GET_CUSTOMER_DATA:String  = "assets/customer.xml"		
		public static var m_customerHashMap:TiHashMap =new TiHashMap();
		public static var m_customerNewHashMap:TiHashMap =new TiHashMap();
		
		public static var ADD_MESSAGE:String=""
		public static var GET_COUNT:String="";
		public static var GET_MESSAGE:String="";
		public static var GET_MESSAGELIST:String="";
		public static var m_stageWidth:int=1920;
		public static var m_stageHeight:int=1080;
		public static var m_myMessageId:String="";
		public static var m_currentEnlargeMoonId:String="";
	//	public static var m_WX:Number=1920;
	//	public static var m_WY:Number=1080;
		
		public static var m_moveX:Number = 0;
		public static var m_moveY:Number = 0;
		
		
		public function AppSetting()
		{
			
		}
		
		public static function set m_RootDomain(value:String):void 
		{
			DOMAIN = value;
			
				//http://isabelle.drowl.com.tw/Mooncake2014/conn/GetCount.aspx	
				//public
				ADD_MESSAGE			= DOMAIN + "AddMessage.aspx";
				GET_COUNT 			= DOMAIN + "GetCount.aspx";
				GET_MESSAGE			= DOMAIN + "GetMessage.aspx";
				GET_MESSAGELIST		= DOMAIN + "GetMessageList.aspx";
			
		}
		
		
		public static function fnMovePositionByScreenResolution(mc:MovieClip):Point
		{
			var point:Point = new Point();
			point.x = m_stageWidth/2 - mc.width/2
			point.y = m_stageHeight/2 - mc.height/2
				
			return point
		}
		
		public static function fnScalePercentByScreenResolution():Object
		{
			var ob:Object = new Object();
			ob.scale_x = m_stageWidth/1920;
			ob.scale_y = m_stageHeight/1080;
			return ob;
		}
	}
}