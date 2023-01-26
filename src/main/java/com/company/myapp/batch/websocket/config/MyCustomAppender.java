package com.company.myapp.batch.websocket.config;

import java.io.Serializable;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import org.apache.logging.log4j.core.Appender;
import org.apache.logging.log4j.core.Core;
import org.apache.logging.log4j.core.Filter;
import org.apache.logging.log4j.core.Layout;
import org.apache.logging.log4j.core.LogEvent;
import org.apache.logging.log4j.core.appender.AbstractAppender;
import org.apache.logging.log4j.core.config.plugins.Plugin;
import org.apache.logging.log4j.core.config.plugins.PluginAttribute;
import org.apache.logging.log4j.core.config.plugins.PluginElement;
import org.apache.logging.log4j.core.config.plugins.PluginFactory;
import org.apache.logging.log4j.core.layout.PatternLayout;
import org.springframework.context.annotation.Configuration;

import com.company.myapp.batch.activemq.Consumer;
import com.company.myapp.batch.websocket.WebSocketManagement;

@Plugin(name="MyCustomAppender", category = Core.CATEGORY_NAME, elementType = Appender.ELEMENT_TYPE, printObject = true)
public class MyCustomAppender extends AbstractAppender{
	
	private final ReadWriteLock readWriteLock = new ReentrantReadWriteLock();
	private final Lock readLock = readWriteLock.readLock();
	
	protected MyCustomAppender(String name, Filter filter, Layout<? extends Serializable> layout,
			boolean ignoreExceptions) {
		super(name, filter, layout, ignoreExceptions, null);
	}
	
	@PluginFactory
	public static MyCustomAppender createAppender(@PluginAttribute("name") String name,
			@PluginElement("Layout") Layout<? extends Serializable> layout,
			@PluginElement("Filter") final Filter filter, @PluginAttribute("otherAttribute") String otherAttribute) {
		if (name == null) {
			LOGGER.error("MyCustomAppender에 제공된 이름이 없습니다.");
			return null;
		}
		if (layout == null) {
			layout = PatternLayout.createDefaultLayout();
		}
		return new MyCustomAppender(name, filter, layout, true);

	}
	
	WebSocketManagement ws = new WebSocketManagement();
	
	@Override
	public void append(LogEvent event) {
		readLock.lock();
		
		final byte[] bytes = getLayout().toByteArray(event);
		String message = new String(bytes);
		
		ws.onMessage(message);
		
		System.out.print(message);
		
		readLock.unlock();
	}
}
