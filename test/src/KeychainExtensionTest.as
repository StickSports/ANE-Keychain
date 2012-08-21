package
{
	import com.sticksports.nativeExtensions.keychain.Keychain;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	[SWF(width='320', height='480', frameRate='30', backgroundColor='#000000')]
	
	public class KeychainExtensionTest extends Sprite
	{
		private var direction : int = 1;
		private var shape : Shape;
		private var feedback : TextField;
		
		private var buttonFormat : TextFormat;
		
		private var accessGroup : String = "5UAS77B3P7.*";
		
		public function KeychainExtensionTest()
		{
			shape = new Shape();
			shape.graphics.beginFill( 0x666666 );
			shape.graphics.drawCircle( 0, 0, 100 );
			shape.graphics.endFill();
			shape.x = 0;
			shape.y = 240;
			addChild( shape );
			
			feedback = new TextField();
			var format : TextFormat = new TextFormat();
			format.font = "_sans";
			format.size = 16;
			format.color = 0xFFFFFF;
			feedback.defaultTextFormat = format;
			feedback.width = 320;
			feedback.height = 260;
			feedback.x = 10;
			feedback.y = 210;
			feedback.multiline = true;
			feedback.wordWrap = true;
			feedback.text = "Hello";
			addChild( feedback );
			
			addEventListener( Event.ENTER_FRAME, animate );

			createButtons();
		}
		
		private function createButtons() : void
		{
			var tf : TextField = createButton( "insert" );
			tf.x = 10;
			tf.y = 10;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, insertItem );
			addChild( tf );
			
			tf = createButton( "update" );
			tf.x = 170;
			tf.y = 10;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, updateItem );
			addChild( tf );
			
			tf = createButton( "insert or update" );
			tf.x = 10;
			tf.y = 50;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, storeItem );
			addChild( tf );
			
			tf = createButton( "get" );
			tf.x = 170;
			tf.y = 50;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, getItem );
			addChild( tf );
			
			tf = createButton( "remove" );
			tf.x = 10;
			tf.y = 90;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, removeItem );
			addChild( tf );
			
			tf = createButton( "insert ag" );
			tf.x = 170;
			tf.y = 90;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, insertItemAG );
			addChild( tf );
			
			tf = createButton( "update ag" );
			tf.x = 10;
			tf.y = 130;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, updateItemAG );
			addChild( tf );
			
			tf = createButton( "insert or update ag" );
			tf.x = 170;
			tf.y = 130;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, storeItemAG );
			addChild( tf );
			
			tf = createButton( "get ag" );
			tf.x = 10;
			tf.y = 170;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, getItemAG );
			addChild( tf );
			
			tf = createButton( "remove ag" );
			tf.x = 170;
			tf.y = 170;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, removeItemAG );
			addChild( tf );
		}
		
		private function createButton( label : String ) : TextField
		{
			if( !buttonFormat )
			{
				buttonFormat = new TextFormat();
				buttonFormat.font = "_sans";
				buttonFormat.size = 14;
				buttonFormat.bold = true;
				buttonFormat.color = 0xFFFFFF;
				buttonFormat.align = TextFormatAlign.CENTER;
			}
			
			var textField : TextField = new TextField();
			textField.defaultTextFormat = buttonFormat;
			textField.width = 140;
			textField.height = 30;
			textField.text = label;
			textField.backgroundColor = 0xCC0000;
			textField.background = true;
			textField.selectable = false;
			textField.multiline = false;
			textField.wordWrap = false;
			return textField;
		}
		
		private function insertItem( event : MouseEvent ) : void
		{
			feedback.text = "Keychain.insert( 'myKey', 'myValue' )";
			var result : int = Keychain.insert( 'myKey', 'myValue' );
			feedback.appendText( "\nresult = " + result );
		}
		
		private function updateItem( event : MouseEvent ) : void
		{
			feedback.text = "Keychain.update( 'myKey', 'myOtherValue' )";
			var result : int = Keychain.update( 'myKey', 'myOtherValue' );
			feedback.appendText( "\nresult = " + result );
		}
		
		private function storeItem( event : MouseEvent ) : void
		{
			feedback.text = "Keychain.insertOrUpdate( 'myKey', 'yetAnotherValue' )";
			var result : int = Keychain.insertOrUpdate( 'myKey', 'yetAnotherValue' );
			feedback.appendText( "\nresult = " + result );
		}
		
		private function getItem( event : MouseEvent ) : void
		{
			feedback.text = "Keychain.get( 'myKey' )";
			var value : String = Keychain.get( 'myKey' );
			feedback.appendText( "\nvalue = " + value );
		}
		
		private function removeItem( event : MouseEvent ) : void
		{
			feedback.text = "Keychain.remove( 'myKey' )";
			var result : int = Keychain.remove( 'myKey' );
			feedback.appendText( "\nresult = " + result );
		}
		
		private function insertItemAG( event : MouseEvent ) : void
		{
			feedback.text = "Keychain.insert( 'myKey', 'myValue', '" + accessGroup + "' )";
			var result : int = Keychain.insert( 'myKey', 'myValue', accessGroup );
			feedback.appendText( "\nresult = " + result );
		}
		
		private function updateItemAG( event : MouseEvent ) : void
		{
			feedback.text = "Keychain.update( 'myKey', 'myOtherValue', '" + accessGroup + "' )";
			var result : int = Keychain.update( 'myKey', 'myOtherValue', accessGroup );
			feedback.appendText( "\nresult = " + result );
		}
		
		private function storeItemAG( event : MouseEvent ) : void
		{
			feedback.text = "Keychain.insertOrUpdate( 'myKey', 'yetAnotherValue', '" + accessGroup + "' )";
			var result : int = Keychain.insertOrUpdate( 'myKey', 'yetAnotherValue', accessGroup );
			feedback.appendText( "\nresult = " + result );
		}
		
		private function getItemAG( event : MouseEvent ) : void
		{
			feedback.text = "Keychain.get( 'myKey', '" + accessGroup + "' )";
			var value : String = Keychain.get( 'myKey', accessGroup );
			feedback.appendText( "\nvalue = " + value );
		}
		
		private function removeItemAG( event : MouseEvent ) : void
		{
			feedback.text = "Keychain.remove( 'myKey', '" + accessGroup + "' )";
			var result : int = Keychain.remove( 'myKey', accessGroup );
			feedback.appendText( "\nresult = " + result );
		}
		
		private function animate( event : Event ) : void
		{
			shape.x += direction;
			if( shape.x <= 0 )
			{
				direction = 1;
			}
			if( shape.x > 320 )
			{
				direction = -1;
			}
		}
	}
}