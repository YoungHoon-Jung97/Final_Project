package util;

public class Path {
	private static final String UPLOAD_EMBLEM_DIR = "resources/uploads/emblems/";
	private static final String UPLOAD_STADIUM_DIR ="resources/uploads/stadiums/";
	private static final String UPLOAD_FIELD_DIR ="resources/uploads/fields/";
	private static final String UPLOAD_PROFILE_DIR ="resources/uploads/profiles/";

	public static String getUploadProfileDir() {
		return UPLOAD_PROFILE_DIR;
	}

	public static String getUploadStadiumDir()
	{
		return UPLOAD_STADIUM_DIR;
	}

	public static String getUploadFieldDir()
	{
		return UPLOAD_FIELD_DIR;
	}

	public static String getUploadEmblemDir() {
		return UPLOAD_EMBLEM_DIR;
	}
	
}
