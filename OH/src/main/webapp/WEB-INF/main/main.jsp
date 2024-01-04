<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>상품 리스트 페이지</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <!-- jQuery, Popper.js, Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    
    <style>
	    body {
	    font-family: 'BigTextFont', sans-serif;
		}
	    
	    .big-text {
	    font-family: 'BigTextFont', sans-serif;
		}
		
		#small-text {
		    font-family: 'SmallTextFont', sans-serif;
		}
		
		#number-font {
		    font-family: 'NumberFont', sans-serif;
		}
        .card-img-overlay {
            display: none;
            background-color: rgba(255, 255, 255, 0.6);
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            height: 100%;
            width: 100%;
            padding: 0;
            align-items: center;
            justify-content: center;
            transition: .5s ease;
        }
        .card:hover .card-img-overlay {
            display: flex;
        }
        
	    .modal-content {
            min-height: 20vh;  
        }
        
    </style>
</head>
<body>
    <div class="container mt-5" id="mainlist">
        <div class="default text-center d-flex justify-content-center">
            <button type="button" class="btn btn-primary mr-2">상품 리스트</button>
            <a href="../main/cart.do" class="btn btn-secondary ml-2">장바구니</a>
        </div>
        <hr>
        <div class="row">
           
            <div class="col-lg-3 col-md-6 mb-4" v-for="(vo, index) in list" style="padding-bottom: 30px">
            	<span id="number-font" style="font-size: 30px;">
            	{{ vo.pcno.toString().startsWith('0') ? vo.pcno : '0' + vo.pcno }}
            	</span>
                <div class="card h-100 position-relative">
                    <img class="card-img-top" :src="'/img/' + vo.img" alt="상품 이미지" style="margin-top: 10px">
                    
                    <div class="card-img-overlay">
		                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal-${index}" 
		                v-on:click="setSelectedPcno(vo.pcno)">장바구니에 추가
		                </button>
		            </div>
                    <div class="card-body" style="margin-bottom: 0; padding-bottom: 0;">
                    	<div v-if="vo.pcno === 5"><img src="/img/베스트1.png" alt="베스트"></div><br>
                        <h3 class="card-title">{{vo.name}}</h3>
                        <hr>
                        <p class="card-text" id="small-font">{{vo.detail}}</p>
                        <div class="card-body-footer" id="number-font">
                            <span style="font-size: 1.3em;">{{vo.strDprice}}원</span>&nbsp;
							<strike id="small-text">{{vo.strPrice}}원</strike>&nbsp;
							<span style="color: red;">{{vo.discount}}%</span>
                        </div>
                        <div v-if="vo.method === '냉동'" style="color: blue; padding-top: 15px;">
						    {{vo.method}}
						</div>
						<div v-else-if="vo.method === '냉장'" style="color: skyblue; padding-top: 15px;">
						    {{vo.method}}
						</div>
						<div v-else style="padding-top: 15px;">
						    {{vo.method}}
						</div>
                    </div>
                </div>
            </div>
            <!-- 모달 창 -->
	        <div class="modal fade" id="myModal-${index}" tabindex="-1" role="dialog" 
	        aria-labelledby="exampleModalLabel" aria-hidden="true">
			    <div class="modal-dialog modal-dialog-centered" role="document">
			        <div class="modal-content text-center">
			            <div class="modal-header">
			                <h5 class="modal-title" id="exampleModalLabel">상품 추가</h5>
			                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			                    <span aria-hidden="true">&times;</span>
			                </button>
			            </div>
			            <div class="modal-body">
			                상품을 장바구니에 추가하시겠습니까?
			            </div>
			            <div class="modal-footer justify-content-center">
			                <button type="button" class="btn btn-secondary" data-dismiss="modal">계속 쇼핑하기</button>
			                <button type="button" class="btn btn-primary" v-on:click="insertCart" >장바구니에 담기</button>
			            </div>
			        </div>
			    </div>
			</div>
            
        </div>
    </div>
    <script>
		new Vue({
			el:'#mainlist',
			data:{
				list:[],
				selectedPcno: null  // 추가
			},
			mounted:function(){
				this.send()
			},
			methods:{
				send:function(){
					axios.get("../main/main_vue.do").then(response=>{
						console.log(response.data)
						this.list = response.data
					}).catch(error=>{
						console.log(error.response)
					})
				},
				
				setSelectedPcno: function(pcno) {  // 상품 mouseover시 데이터 값 저장
		            this.selectedPcno = pcno;
		        },
		        
		        insertCart: function() {  // 장바구니에 넣기
		            axios.get("../main/insert_vue.do", {
		                params: {
		                    pcno: this.selectedPcno  // 수정
		                }
		            })
		            .then(response => {
				        alert('장바구니 담기 완료');
				        window.location.href = '../main/main.do'; // 메인 화면으로 이동
				    })
		            .catch(error => {
		            	if (error.response && error.response.data) {
		                    alert('이미 추가한 상품입니다.');
		                } else {
		                    console.log(error);
		                }
		            });
		        }
			}
			
		})
	</script>
    
</body>
</html>
