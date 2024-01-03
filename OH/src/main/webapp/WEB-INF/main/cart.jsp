<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 페이지</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.12/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios@0.21.1/dist/axios.min.js"></script>

<style>

	body {
    font-family: 'BigTextFont', sans-serif;
	}
    
    .big-text {
    font-family: 'BigTextFont', sans-serif;
	}
	
	.small-text {
	    font-family: 'SmallTextFont', sans-serif;
	}
	
	#number {
	    font-family: 'NumberFont', sans-serif;
	}
	
  .product-img {
    max-width: 100px;
    height: auto;
    border: 1px solid #000;
    
    padding: 10px; /* 이미지 내부의 여백 */
    background: #ffffff; /* 여백 영역의 배경색 */
    border: 0.2px solid #ddd; /* 테두리 선 굵기를 0.5px로 설정 */
  }
  .image-cell{
    text-align: center; /* 가로 중앙 정렬 */
    vertical-align: middle; /* 세로 중앙 정렬 */
	}

</style>
</head>
<body>
<div class="container mt-5" id="app">
	<div style="text-align: center; font-size: 1.5em;">장바구니</div>
	<hr>
    <table class="table">
        <thead>
            <tr style="background-color: #f9f9f9;">
            	<th scope="col"></th>
                <th scope="col">상품명</th>
                <th scope="col">구매가</th>
                <th scope="col">수량</th>
                <th scope="col">금액</th>
                <th scope="col"></th>
                
            </tr>
        </thead>
        <tbody>
		    <tr v-for="(vo, index) in clist">
		    	<td class="image-cell"><img :src="'/img/' + vo.img" alt="image" class="product-img"></td>
		        <td class="align-middle">{{ vo.name }}</td>
		        <td class="align-middle" id="number">
				  <span style="font-size: larger;">{{ vo.strDprice }}원</span><br>
				  <span class="small-text" style="font-size: smaller; text-decoration: line-through;">{{vo.strPrice}}원</span>
				</td>
		        <td class="align-middle" id="number">
		        	<button @click="decreaseCount(vo)" style="background-color: transparent;">-</button>
					&nbsp;&nbsp;{{ vo.count }}&nbsp;&nbsp;
					<button @click="increaseCount(vo)" style="background-color: transparent;">+</button>
		        </td>
		        <td class="align-middle" id="number">{{ totalPrice(vo) }}원</td>
		        <td class="align-middle">
		        	<button @click="removeItem(index, vo.pcno)" style="background-color: transparent;">삭제</button>
		        </td> <!-- 삭제 버튼 추가 -->
		        
		    </tr>
		    
		</tbody>
    </table>
    <hr>
		<div class="row">
		    <div class="col-12 text-center">
		        <h4>
		            <small style="font-size: 0.7em;">총 금액</small> <span id="number">{{ totalPayment() }}</span>원 &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp;&nbsp;&nbsp;&nbsp;
		            <small style="font-size: 0.7em;">배송비</small>  <span id="number">{{ shippingFee() }}</span>원 <small style="font-size: 0.7em;">(3만원이상 구매 시 무료배송)</small> &nbsp;&nbsp;&nbsp;&nbsp; = &nbsp;&nbsp;&nbsp;&nbsp;
		            <small style="font-size: 0.7em;">결제 금액</small>  <span id="number">{{ finalPayment() }}</span>원
		        </h4>
		    </div>
		</div>

	<hr>
	<div class="row">
	    <div class="col-12 text-center">        
	        <button class="btn btn-secondary" @click="goToProductList">상품 목록</button>
	        <button class="btn btn-primary" @click="saveCart">장바구니 저장</button>
	    </div>
	</div>

	</div>

	<script>
		new Vue({
		  el: '#app',
		  data: {
			clist:[]
		  },
		  mounted:function(){
				this.send()
		  },
		  methods: {
			  send:function(){
					axios.get("../main/cart_vue.do").then(response=>{
						console.log(response.data)
						this.clist = response.data
					}).catch(error=>{
						console.log(error.response)
					})
				},
				
				increaseCount: function(vo) {
					vo.count++;
				},
				
				decreaseCount: function(vo) {
					if(vo.count > 1) vo.count--; // 조건 변경: 수량이 1보다 클 때만 감소
				},
				
				addCommas: function(value) {
			        return value.toLocaleString();	// 1000원 단위 ,콤마 표시 string 형 반환
			    },
			    
				totalPrice: function(vo) {
					var tprice = vo.count * vo.dprice;
					return this.addCommas(tprice);
				},
				
			    totalPayment: function() {
			        // 총 금액 계산 (배송비 미포함)
			        var tpay = this.clist.reduce((total, vo) => total + parseInt(this.totalPrice(vo).replace(/,/g, '')), 0);
			        return this.addCommas(tpay); // 콤마 추가
			    },

			    shippingFee: function() {
			        // 배송비 계산
			        var fee = this.totalPayment().replace(/,/g, '') >= 30000 ? 0 : 3000;
			        return this.addCommas(fee); // 콤마 추가
			    },

			    finalPayment: function() {
			        // 최종 결제금액 (배송비 포함)
			        var fpay = parseInt(this.totalPayment().replace(/,/g, '')) + parseInt(this.shippingFee().replace(/,/g, ''));
			        return this.addCommas(fpay); // 숫자를 천 단위로 구분하여 문자열로 반환
			    },
			    
				removeItem: function(index, pcno) {
		            
		            axios.get("../main/delete_vue.do", { params: { pcno: pcno } })
		                .then(response => {
		                    console.log(response.data); 
		                    this.clist.splice(index, 1); // 선택한 항목을(index) 배열에서 제거(1개) 
		                    alert('장바구니 삭제 완료');
		                })
		                .catch(error => {
		                    console.log(error.response);
		                });
		        },
		        
		        saveCart: function() {
		            console.log('장바구니 저장');
		            // 모든 아이템 저장 작업을 담을 배열
		            let saveTasks = [];

		            this.clist.forEach(item => {
		                // axios 요청은 Promise를 반환하므로, 이를 배열에 담습니다.
		                let task = axios.get("../main/update_vue.do", { params: { pcno: item.pcno, count: item.count } })
		                saveTasks.push(task);
		            });

		            // Promise.all을 사용하여 모든 저장 작업이 완료되면 알림 메시지를 보냅니다.
		            Promise.all(saveTasks)
		                .then(responses => {
		                    responses.forEach(response => console.log(response.data)); // 각 응답 출력
		                    alert('장바구니 저장 완료');
		                })
		                .catch(errors => {
		                    errors.forEach(error => console.log(error.response));
		                });
		        },
		        
	            goToProductList: function() {
	                // 상품 목록 페이지로 이동
	                console.log('상품 목록 페이지로 이동');
	                window.location.href = '../main/main.do'; 
	            }	            
		  }
		})
	</script>

</body>
</html>
