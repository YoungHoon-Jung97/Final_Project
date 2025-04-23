package com.nutmag.project.dto;

import java.security.Timestamp;
import java.util.Date;

public class MercenaryOfferDTO {
	 // 용병 신청 기본 정보
    private int mercenary_offer_id;
    private Timestamp mercenary_offer_at;
    private int field_res_id;
    private int mercenary_id;
    private int team_id;
    
    // 용병 개인 정보
    private int user_code_id;
    private int position_id;
    private int region_id;
    private int city_id;
    private String position_name;
    private String region_name;
    private String city_name;
    private String user_name;
    private String user_nick_name;
    
    // 경기 정보
    private Date match_date;
    private String start_time;
    private String end_time;
    private String field_name;
    private String stadium_name;
    private String stadium_addr;
    private String stadium_detailed_addr;
    private String home_team_name;
    private String away_team_name;
    private String match_status;
    
    // 고용 팀 정보
    private String offer_team_name;
    
    // 기본 생성자
    public MercenaryOfferDTO() {
    }
    
    // Getters and Setters
    public int getMercenary_offer_id() {
        return mercenary_offer_id;
    }
    
    public void setMercenary_offer_id(int mercenary_offer_id) {
        this.mercenary_offer_id = mercenary_offer_id;
    }
    
    public Timestamp getMercenary_offer_at() {
        return mercenary_offer_at;
    }
    
    public void setMercenary_offer_at(Timestamp mercenary_offer_at) {
        this.mercenary_offer_at = mercenary_offer_at;
    }
    
    public int getField_res_id() {
        return field_res_id;
    }
    
    public void setField_res_id(int field_res_id) {
        this.field_res_id = field_res_id;
    }
    
    public int getMercenary_id() {
        return mercenary_id;
    }
    
    public void setMercenary_id(int mercenary_id) {
        this.mercenary_id = mercenary_id;
    }
    
    public int getTeam_id() {
        return team_id;
    }
    
    public void setTeam_id(int team_id) {
        this.team_id = team_id;
    }
    
    public int getUser_code_id() {
        return user_code_id;
    }
    
    public void setUser_code_id(int user_code_id) {
        this.user_code_id = user_code_id;
    }
    
    public int getPosition_id() {
        return position_id;
    }
    
    public void setPosition_id(int position_id) {
        this.position_id = position_id;
    }
    
    public int getRegion_id() {
        return region_id;
    }
    
    public void setRegion_id(int region_id) {
        this.region_id = region_id;
    }
    
    public int getCity_id() {
        return city_id;
    }
    
    public void setCity_id(int city_id) {
        this.city_id = city_id;
    }
    
    public String getPosition_name() {
        return position_name;
    }
    
    public void setPosition_name(String position_name) {
        this.position_name = position_name;
    }
    
    public String getRegion_name() {
        return region_name;
    }
    
    public void setRegion_name(String region_name) {
        this.region_name = region_name;
    }
    
    public String getCity_name() {
        return city_name;
    }
    
    public void setCity_name(String city_name) {
        this.city_name = city_name;
    }
    
    public String getUser_name() {
        return user_name;
    }
    
    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }
    
    public String getUser_nick_name() {
        return user_nick_name;
    }
    
    public void setUser_nick_name(String user_nick_name) {
        this.user_nick_name = user_nick_name;
    }
    
    public Date getMatch_date() {
        return match_date;
    }
    
    public void setMatch_date(Date match_date) {
        this.match_date = match_date;
    }
    
    public String getStart_time() {
        return start_time;
    }
    
    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }
    
    public String getEnd_time() {
        return end_time;
    }
    
    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }
    
    public String getField_name() {
        return field_name;
    }
    
    public void setField_name(String field_name) {
        this.field_name = field_name;
    }
    
    public String getStadium_name() {
        return stadium_name;
    }
    
    public void setStadium_name(String stadium_name) {
        this.stadium_name = stadium_name;
    }
    
    public String getStadium_addr() {
        return stadium_addr;
    }
    
    public void setStadium_addr(String stadium_addr) {
        this.stadium_addr = stadium_addr;
    }
    
    public String getStadium_detailed_addr() {
        return stadium_detailed_addr;
    }
    
    public void setStadium_detailed_addr(String stadium_detailed_addr) {
        this.stadium_detailed_addr = stadium_detailed_addr;
    }
    
    public String getHome_team_name() {
        return home_team_name;
    }
    
    public void setHome_team_name(String home_team_name) {
        this.home_team_name = home_team_name;
    }
    
    public String getAway_team_name() {
        return away_team_name;
    }
    
    public void setAway_team_name(String away_team_name) {
        this.away_team_name = away_team_name;
    }
    
    public String getMatch_status() {
        return match_status;
    }
    
    public void setMatch_status(String match_status) {
        this.match_status = match_status;
    }
    
    public String getOffer_team_name() {
        return offer_team_name;
    }
    
    public void setOffer_team_name(String offer_team_name) {
        this.offer_team_name = offer_team_name;
    }
    
    @Override
    public String toString() {
        return "MercenaryOfferDTO [mercenary_offer_id=" + mercenary_offer_id + ", mercenary_offer_at=" + mercenary_offer_at
                + ", field_res_id=" + field_res_id + ", mercenary_id=" + mercenary_id + ", team_id=" + team_id
                + ", user_code_id=" + user_code_id + ", position_name=" + position_name + ", region_name=" + region_name
                + ", city_name=" + city_name + ", user_name=" + user_name + ", user_nick_name=" + user_nick_name
                + ", match_date=" + match_date + ", stadium_name=" + stadium_name + ", match_status=" + match_status
                + ", offer_team_name=" + offer_team_name + "]";
    }
}
