class ReplyService{
	static test(callback){
		console.log("test....");
		if(callback){
			let param1 = 11;
			let param2 = 22;
			callback(param1, param2);
		}
	}
	static add(reply, callback, error){
		$.ajax({
			type:"post",
			url:"${path}/replies/new",
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success:function(result, status, xhr){
				if(callback){
					callback(status)
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(xhr.status + ' ' + status);
				}
			}
		});
	}
	static getList(param, callback, error){
		let bno = param.bno
		$.getJSON("${path}/replies/pages/" + bno, function(data){
			if(callback){
				console.log(data);
				callback(data);
			}
			var items = data;
		}).fail(function(xhr, status, err){
			if(error){
				error(xhr.status + ' ' + status);
			}
		});
	}
	static displayTime(timeValue) {
		let today= new Date();
		let gap = today.getTime()-timeValue;
		let dateObj = new Date(timeValue);
		let str="";
		if(gap < (1000 * 60 * 60 * 24)) {
			let hh = dateObj.getHours();
			let mi = dateObj.getMinutes();
			let ss = dateObj.getSeconds();
			return [ (hh>9 ? '': '0') + hh, ':', (mi >9 ? '':'0') +mi, ':', (ss>9 ? '' : '0')+ss].join('');
		} else {
			let yy=dateObj.getFullYear();
			let mm=dateObj.getMonth() +1; //getMonth is zero-based
			let dd=dateObj.getDate();
			return[ yy, '/', (mm>9 ? '':'0') +mm, '/', (dd>9 ?'':'0')+dd ].join('');
		}
	}
	static get(rno, callback, error){
		$.get("${path}/replies/get/" + rno, function(result){
			if(callback){
				console.log(result);
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	static modify(reply, callback, error){
		$.ajax({
			type:"patch",
			url:"${path}/replies/update",
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success:function(updateResult, status, xhr){
				if(callback){
					callback(updateResult)
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(xhr.status + ' ' + status);
				}
			}
		});
	}
	static remove(rno, callback, error){
		$.ajax({
			type:"delete",
			url:"${path}/replies/delete/" + rno,
			contentType: "application/json; charset=utf-8",
			success:function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult)
				}
			},
			error:function(xhr, status, er){
				if(error){
					error(xhr.status + ' ' + status);
				}
			}
		});
	}
	static getListWithPaging(param, callback, error){
		let bno = param.bno;
		let page = param.page;
		$.getJSON("${path}/replies/pages/" + bno + "/" + page, function(data){
			if(callback){
				console.log(data);
				callback(data.replyCnt, data.list);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error(xhr.status + ' ' + status);
			}
		});
	}
}