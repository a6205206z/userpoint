/**
@author binbin.yin
@param brand_id 
@param model_id     
@param type_id     
@param defaultBrand 
@param defaultModel    
@param defaultType  
*/
(function($) {
	$.car=function(brand_id, model_id, type_id, defaultBrand, defaultModel, defaultType){
		var brand=$('#'+brand_id),model=$('#'+model_id),type=$('#'+type_id),brand_opt='';
		$.car.setOption(brand,$.car.list,defaultBrand);
		brand.change(function(){
			var brandIndex=$.car.getIndex(brand);
			$.car.setOption(model,$.car.list[brandIndex].c,defaultModel);
			$.car.setOption(type,$.car.list[brandIndex].c[$.car.getIndex(model)].a,defaultType);
		});
		var brandIndex=$.car.getIndex(brand);
		$.car.setOption(model,$.car.list[brandIndex].c,defaultModel);
		model.change(function(){
			$.car.setOption(type,$.car.list[$.car.getIndex(brand)].c[$.car.getIndex(model)].a,defaultType);
		});
		$.car.setOption(type,$.car.list[brandIndex].c[$.car.getIndex(model)].a,defaultType);
	};
	$.car.getIndex=function(dom){return parseInt(dom.find('option:selected').attr('index'));};
	$.car.setOption=function(dom,obj,str){
		var opt='';
		$.each(obj,function(i,v){
			var text='object'==typeof v ? v.n : v;
			var selected = 'undefined'==typeof str || text!= str ? '' : ' selected';
			opt+='<option index="'+i+'" value="'+text+'"'+selected+'>'+text+'</option>';
		});
		dom.html(opt);
	}
	$.car.list=[
	{
		n: '东风标致',
		c: [
		{
			n: '标致301',
			a: [
			'2014款1.6L手动舒适版',
			'2014款1.6L自动舒适版',
			'2014款1.6L手动豪华版',
			'2014款自动豪华版',
			'2014款自动尊贵版'
			]
		},
		{
			n: '标致308',
			a: [
			'2014款 乐享版 1.6L 手动优尚型CNG',
			'2014款 乐享版 1.6L 手动优尚型',
			'2014款 乐享版 1.6L 自动优尚型',
			'2014款 乐享版 1.6L 手动风尚型',
			'2014款 乐享版 1.6L 自动风尚型',
			'2014款 乐享版 2.0L 手动风尚型',
			'2014款 乐享版 2.0L 自动风尚型'
			]
		},
		{
			n: '标致308S',
			a: [
			'2015款 1.6L 手动尚驰版',
			'2015款 1.6L 手动劲驰版',
			'2015款 1.2T 自动尚驰版',
			'2015款 1.2T 自动劲驰版',
			'2015款 1.6T 自动劲驰版',
			'2015款 1.6T 自动睿驰版',
			'这里填写车型配置'
			]
		},
		{
			n: '标致408',
			a: [
			'2015款 1.2T 自动豪华版',
			'2014款 1.8L 手动领先版',
			'2014款 1.8L 自动领先版',
			'2014款 1.8L 自动豪华版',
			'2014款 1.6T 自动尊贵版',
			'2014款 1.6T 自动至尊版'
			]
		},
		{
			n: '标致508',
			a: [
			'2015款 2.0L 自动致逸版',
			'2015款 2.0L 自动致臻版',
			'2015款 1.6THP 自动致逸版',
			'2015款 1.6THP 自动致臻版',
			'2015款 1.8THP 自动致臻版',
			'2015款 1.8THP 自动致尊版',
			'2015款 1.8THP 自动旗舰版'
			]
		},
		{
			n: '标致2008',
			a: [
			'2014款 1.6L 手动潮流版',
			'2014款 1.6L 自动潮流版',
			'2014款 1.6L 手动时尚版',
			'2014款 1.6L 自动时尚版',
			'2014款 1.6L 手动卓越版',
			'2014款 1.6L 自动卓越版',
			'2014款 1.6L 自动领航版',
			'2015款 1.6THP 自动时尚版',
			'2015款 1.6THP 罗兰·加洛斯版',
			'2015款 1.6THP 自动领航版'
			]
		},
		{
			n: '标致3008',
			a: [
			'2015款 2.0L 手动经典版',
			'2015款 2.0L 自动经典版',
			'2015款 2.0L 手动潮流版',
			'2015款 2.0L 自动潮流版',
			'2015款 1.6THP 自动经典版',
			'2015款 1.6THP 自动潮流版',
			'2015款 1.6THP 自动至尚版',
			'2015款 1.6THP 罗兰·加洛斯版'
			]
		}
		]
	}
	];
})(jQuery);