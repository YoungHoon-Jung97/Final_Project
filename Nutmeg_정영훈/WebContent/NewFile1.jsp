<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>풋살 선수 리스트</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        body {
            background-color: #f4f6f9;
            color: #333;
            line-height: 1.6;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px 0;
            margin-bottom: 30px;
            border-radius: 5px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        }
        
        header h1 {
            text-align: center;
            font-size: 2.5rem;
        }
        
        .search-filter {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .search-bar {
            flex: 2;
            min-width: 300px;
        }
        
        .search-bar input {
            width: 100%;
            padding: 10px 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 1rem;
        }
        
        .filters {
            flex: 1;
            display: flex;
            gap: 10px;
            min-width: 300px;
            justify-content: flex-end;
        }
        
        .filters select {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            background-color: white;
            font-size: 1rem;
        }
        
        .player-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }
        
        .player-card {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .player-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.15);
        }
        
        .player-image {
            height: 200px;
            background-color: #ddd;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        
        .player-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .player-info {
            padding: 20px;
        }
        
        .player-name {
            font-size: 1.4rem;
            font-weight: bold;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        
        .player-position {
            background-color: #3498db;
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.9rem;
            display: inline-block;
            margin-bottom: 10px;
        }
        
        .player-stats {
            display: flex;
            flex-wrap: wrap;
            margin-bottom: 15px;
        }
        
        .stat {
            flex: 1;
            min-width: 85px;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 0.8rem;
            color: #7f8c8d;
        }
        
        .stat-value {
            font-size: 1rem;
            font-weight: bold;
        }
        
        .player-description {
            font-size: 0.9rem;
            color: #555;
            margin-bottom: 15px;
            line-height: 1.5;
        }
        
        .player-actions {
            display: flex;
            justify-content: space-between;
        }
        
        .action-button {
            flex: 1;
            padding: 8px 0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
            text-align: center;
        }
        
        .recruit-button {
            background-color: #2ecc71;
            color: white;
            margin-right: 5px;
        }
        
        .details-button {
            background-color: #f1f1f1;
            color: #333;
            margin-left: 5px;
        }
        
        .recruit-button:hover {
            background-color: #27ae60;
        }
        
        .details-button:hover {
            background-color: #e0e0e0;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }
        
        .pagination a {
            margin: 0 5px;
            padding: 8px 15px;
            border-radius: 5px;
            background-color: white;
            color: #333;
            text-decoration: none;
            transition: background-color 0.3s ease;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .pagination a.active {
            background-color: #3498db;
            color: white;
        }
        
        .pagination a:hover:not(.active) {
            background-color: #f1f1f1;
        }
        
        footer {
            text-align: center;
            margin-top: 50px;
            color: #7f8c8d;
            font-size: 0.9rem;
        }
        
        @media (max-width: 768px) {
            .search-filter {
                flex-direction: column;
                align-items: stretch;
            }
            
            .filters {
                justify-content: space-between;
            }
            
            .player-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>풋살 선수 리스트</h1>
        </header>
        
        <div class="search-filter">
            <div class="search-bar">
                <input type="text" placeholder="선수 이름 검색...">
            </div>
            <div class="filters">
                <select>
                    <option value="">포지션 전체</option>
                    <option value="pivot">피봇</option>
                    <option value="ala">아라</option>
                    <option value="fixo">픽소</option>
                    <option value="goleiro">골키퍼</option>
                </select>
                <select>
                    <option value="">등급 전체</option>
                    <option value="S">S급</option>
                    <option value="A">A급</option>
                    <option value="B">B급</option>
                    <option value="C">C급</option>
                </select>
            </div>
        </div>
        
        <div class="player-grid">
            <!-- 선수 카드 1 -->
            <div class="player-card">
                <div class="player-image">
                    <img src="/api/placeholder/300/200" alt="파워 피보트 이준호">
                </div>
                <div class="player-info">
                    <div class="player-name">이준호</div>
                    <div class="player-position">피봇</div>
                    <div class="player-stats">
                        <div class="stat">
                            <div class="stat-label">등급</div>
                            <div class="stat-value">S</div>
                        </div>
                        <div class="stat">
                            <div class="stat-label">공격력</div>
                            <div class="stat-value">87</div>
                        </div>
                        <div class="stat">
                            <div class="stat-label">수비력</div>
                            <div class="stat-value">82</div>
                        </div>
                    </div>
                    <div class="player-description">
                        강력한 슈팅과 피지컬로 팀의 공격을 이끄는 최고의 피봇. 골 결정력이 뛰어나 팀의 득점원으로 활약합니다.
                    </div>
                    <div class="player-actions">
                        <button class="action-button recruit-button">영입하기</button>
                        <button class="action-button details-button">상세정보</button>
                    </div>
                </div>
            </div>
            
            <!-- 선수 카드 2 -->
            <div class="player-card">
                <div class="player-image">
                    <img src="/api/placeholder/300/200" alt="윙어 김서연">
                </div>
                <div class="player-info">
                    <div class="player-name">김서연</div>
                    <div class="player-position">아라</div>
                    <div class="player-stats">
                        <div class="stat">
                            <div class="stat-label">등급</div>
                            <div class="stat-value">A</div>
                        </div>
                        <div class="stat">
                            <div class="stat-label">속도</div>
                            <div class="stat-value">92</div>
                        </div>
                        <div class="stat">
                            <div class="stat-label">드리블</div>
                            <div class="stat-value">88</div>
                        </div>
                    </div>
                    <div class="player-description">
                        빠른 스피드와 환상적인 드리블로 측면을 파고드는 윙 스페셜리스트. 정확한 크로스 능력을 보유하고 있습니다.
                    </div>
                    <div class="player-actions">
                        <button class="action-button recruit-button">영입하기</button>
                        <button class="action-button details-button">상세정보</button>
                    </div>
                </div>
            </div>
            
            <!-- 선수 카드 3 -->
            <div class="player-card">
                <div class="player-image">
                    <img src="/api/placeholder/300/200" alt="수비형 미드필더 박민준">
                </div>
                <div class="player-info">
                    <div class="player-name">박민준</div>
                    <div class="player-position">픽소</div>
                    <div class="player-stats">
                        <div class="stat">
                            <div class="stat-label">등급</div>
                            <div class="stat-value">S</div>
                        </div>
                        <div class="stat">
                            <div class="stat-label">패스</div>
                            <div class="stat-value">94</div>
                        </div>
                        <div class="stat">
                            <div class="stat-label">수비력</div>
                            <div class="stat-value">90</div>
                        </div>
                    </div>
                    <div class="player-description">
                        경기의 흐름을 읽고 정확한 패스로 팀 플레이를 조율하는 픽소. 수비와 공격의 연결점 역할을 담당합니다.
                    </div>
                    <div class="player-actions">
                        <button class="action-button recruit-button">영입하기</button>
                        <button class="action-button details-button">상세정보</button>
                    </div>
                </div>
            </div>
            
            <!-- 선수 카드 4 -->
            <div class="player-card">
                <div class="player-image">
                    <img src="/api/placeholder/300/200" alt="골키퍼 최지훈">
                </div>
                <div class="player-info">
                    <div class="player-name">최지훈</div>
                    <div class="player-position">골키퍼</div>
                    <div class="player-stats">
                        <div class="stat">
                            <div class="stat-label">등급</div>
                            <div class="stat-value">A</div>
                        </div>
                        <div class="stat">
                            <div class="stat-label">반사신경</div>
                            <div class="stat-value">89</div>
                        </div>
                        <div class="stat">
                            <div class="stat-label">포지셔닝</div>
                            <div class="stat-value">87</div>
                        </div>
                    </div>
                    <div class="player-description">
                        뛰어난 선방 능력과 경기 읽는 눈으로 팀의 마지막 보루 역할을 담당합니다. 발기술도 우수한 현대형 골키퍼입니다.
                    </div>
                    <div class="player-actions">
                        <button class="action-button recruit-button">영입하기</button>
                        <button class="action-button details-button">상세정보</button>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="pagination">
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
            <a href="#">5</a>
            <a href="#">다음 &raquo;</a>
        </div>
        
        <footer>
            <p>&copy; 2025 풋살 선수 데이터베이스. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>