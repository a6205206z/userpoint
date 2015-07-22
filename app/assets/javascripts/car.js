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
			'默认'
			]
		},
		{
			n: '标致308',
			a: [
			'默认',
			'默认'
			]
		},
		{
			n: '标致308S',
			a: [
			'默认',
			'默认'
			]
		},
		{
			n: '标致408',
			a: [
			'默认',
			'默认'
			]
		},
		{
			n: '标致508',
			a: [
			'默认',
			'默认'
			]
		},
		{
			n: '标致2008',
			a: [
			'默认',
			'默认'
			]
		},
		{
			n: '标致206',
			a: [
			'默认',
			'默认'
			]
		},
		{
			n: '标致207',
			a: [
			'默认',
			'默认'
			]
		},
		{
			n: '标致307',
			a: [
			'默认',
			'默认'
			]
		}
		]
	}
	];
})(jQuery);