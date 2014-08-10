package lib
{
	import flash.geom.Point;
	
	import spark.components.Group;

	public class Customer extends Group
	{
		public var m_customerId:String="";
		public var m_surname:String="";
		public var m_message:String="";
		public var m_name:String="";
		public var m_phone:String="";
		public var m_email:String="";
		public var m_address:String="";
		public var m_isrequirement:String="是";
		public var m_requirementqty:String="5";
		public var m_isneedcontact:String="是";
		public var m_mySelf:Boolean=false
		public var m_po:Point =new Point();
		public function Customer()
		{
			
		}
		
		
	}
}